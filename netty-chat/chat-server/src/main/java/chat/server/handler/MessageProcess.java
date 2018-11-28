package chat.server.handler;

import chat.server.channel.ChannelContextMap;
import chat.server.channel.DomainChannelMap;
import chat.server.command.ClientCommandEnum;
import chat.server.command.ServerCommandEnum;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.shuangying.core.common.utility.DateUtils;
import com.shuangying.core.db.manager.ReceiveRedbagManager;
import com.shuangying.core.db.manager.RoleManager;
import com.shuangying.core.db.manager.RoomManager;
import com.shuangying.core.db.manager.UserManager;
import com.shuangying.core.db.model.ReceiveRedbag;
import com.shuangying.core.db.model.Room;
import com.shuangying.core.db.model.User;
import io.netty.channel.Channel;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

/**
 * @auther a-de
 * @date 2018/11/7 21:43
 */
@Component
public class MessageProcess {
    private Logger logger = LoggerFactory.getLogger(MessageProcess.class);

    @Autowired
    private ReceiveRedbagManager receiveRedbagManager;

    @Autowired
    private RoomManager roomManager;

    @Autowired
    private UserManager userManager;

    @Autowired
    private RoleManager roleManager;

    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    public void execute(Channel channel, String message) {
        JSONObject jsonObject = JSON.parseObject(message);
        String command = jsonObject.getString("command");
        String domain = jsonObject.getString("domain");
        String roomId = jsonObject.getString("roomId");
        String token = jsonObject.getString("token");
        String userId = jsonObject.getString("userId");
        String userName = jsonObject.getString("userName");
        String userIcon = jsonObject.getString("userIcon");
        String roleName = jsonObject.getString("roleName");
        String content = jsonObject.getString("content");

        //校验sender信息
        if (!DomainChannelMap.checkSender(domain, roomId, token)) {
            return;
        }
        //组装response基本信息
        JSONObject response = createResponse(userId, userName, userIcon, roleName);
        ClientCommandEnum commandEnum = ClientCommandEnum.getEnumBykey(command);
        switch (commandEnum) {
            //发送消息
            case C_MESSAGE:
                sendMessage(userId, domain, roomId, response, content);
                break;
            //踢出聊天室
            case C_REMOVE_CHAT:
                removeChat(userId, domain, roomId, response, content);
                break;
            //禁言
//            case C_FORBID_CHAT:
//                commandResponse(domain, roomId, response,ServerCommandEnum.S_FORBID_CHAT);
//                break;
            //取消禁言
//            case C_UNFORBID_CHAT:
//                commandResponse(domain, roomId, response,ServerCommandEnum.S_UNFORBID_CHAT);
//                break;
            //撤回消息
            case C_RECALL_MESSAGE:
                recallMessage(userId, domain, roomId, response, content);
                break;
            //心跳检测
            case C_HEART_BEAT:
                commandSingleResponse(channel, domain, roomId, response, ServerCommandEnum.S_HEART_BEAT);
                break;
            //发送红包
//            case C_SEND_REDBAG:
//                System.out.print("aaa");
//                break;
            //领取红包
            case C_RECEIVE_REDBAG:
                receiveRedBag(domain, roomId, userId, response, content, channel);
                break;
            //红包领取记录
            case C_REDBAG_RECEIVE_RECORD:
                System.out.print("aaa");
                break;
            default:
                break;
        }
    }

    public void connectError(Channel channel, ServerCommandEnum serverCommandEnum) {
        JSONObject response = new JSONObject();
        response.put("messageId", UUID.randomUUID().toString().replace("-", ""));
        response.put("command", serverCommandEnum.getKey());
        response.put("messageTime", DateUtils.getStrFromDate(new Date(), "HH:mm:ss"));
        channel.writeAndFlush(new TextWebSocketFrame(response.toJSONString()));
    }

    /**
     * 命令response
     *
     * @param domain
     * @param roomId
     * @param response
     * @param serverCommandEnum
     */
    public void commandSingleResponse(Channel channel, String domain, String roomId, JSONObject response, ServerCommandEnum serverCommandEnum) {
        response.put("command", serverCommandEnum.getKey());
        channel.writeAndFlush(new TextWebSocketFrame(response.toJSONString()));
    }

    /**
     * 命令response
     *
     * @param domain
     * @param roomId
     * @param response
     * @param serverCommandEnum
     */
    public void commandAllResponse(String domain, String roomId, JSONObject response, ServerCommandEnum serverCommandEnum) {
        response.put("command", serverCommandEnum.getKey());
        sendRoomMsg(domain, roomId, response.toJSONString());
    }

    /**
     * 发送消息
     *
     * @param domain
     * @param roomId
     * @param response
     * @param contentStr
     */
    public void sendMessage(String userId, String domain, String roomId, JSONObject response, String contentStr) {
        Room room = roomManager.queryByIdCache(Long.parseLong(roomId));
        if (room == null) {
            return;
        }
        if (room.getForbidStatus() == 1) {
            User user = userManager.queryById(Long.parseLong(userId));
            if (!roleManager.queryRolePermAndAuthority(user.getRoleId(), "chat:forbidchat")) {
                return;
            }
        }
        response.put("command", ServerCommandEnum.S_MESSAGE.getKey());
        if (!StringUtils.isEmpty(contentStr)) {
            contentStr = StringEscapeUtils.escapeHtml(contentStr);
            //contentStr = StringEscapeUtils.escapeJavaScript(contentStr);
            //contentStr = StringEscapeUtils.escapeSql(contentStr);
        }
        response.put("content", contentStr);
        HistoryMessageHandler.insert(domain, roomId, response.toJSONString());
        sendRoomMsg(domain, roomId, response.toJSONString());
    }

    /**
     * 踢出用户
     *
     * @param domain
     * @param roomId
     * @param response
     * @param contentStr
     */
    public void removeChat(String userId, String domain, String roomId, JSONObject response, String contentStr) {
        JSONObject content = JSON.parseObject(contentStr);
        String removeId = content.getString("removeId");
        User user = userManager.queryById(Long.parseLong(userId));
        if (user == null) {
            return;
        }
        if (!roleManager.queryRolePermAndAuthority(user.getRoleId(), "chat:remove")) {
            return;
        }
        response.put("command", ServerCommandEnum.S_REMOVE_CHAT.getKey());
        JSONObject contentResponse = new JSONObject();
        contentResponse.put("removeId", removeId);
        response.put("content", contentResponse);
        sendRoomMsg(domain, roomId, response.toJSONString());
    }

    /**
     * 撤回消息
     *
     * @param domain
     * @param roomId
     * @param response
     * @param contentStr
     */
    public void recallMessage(String userId, String domain, String roomId, JSONObject response, String contentStr) {
        User user = userManager.queryById(Long.parseLong(userId));
        if (user == null) {
            return;
        }
        if (!roleManager.queryRolePermAndAuthority(user.getRoleId(), "chat:recall")) {
            return;
        }
        JSONObject content = JSON.parseObject(contentStr);
        String messageId = content.getString("messageId");
        if (StringUtils.isEmpty(messageId)) {
            return;
        }
        HistoryMessageHandler.remove(domain, roomId, messageId);
        response.put("command", ServerCommandEnum.S_RECALL_MESSAGE.getKey());
        JSONObject contentResponse = new JSONObject();
        contentResponse.put("messageId", messageId);
        contentResponse.put("status", 1);
        response.put("content", contentResponse);
        sendRoomMsg(domain, roomId, response.toJSONString());
    }

    /**
     * 领取红包
     *
     * @param domain
     * @param roomId
     * @param response
     * @param contentStr
     */
    public void receiveRedBag(String domain, String roomId, String userId, JSONObject response, String contentStr, Channel channel) {
        JSONObject content = JSON.parseObject(contentStr);
        String redbagId = content.getString("redbagId");
        ReceiveRedbag receiveRedbag = null;
        try {
            receiveRedbag = receiveRedbagManager.userReceivedRedbag(domain, Long.parseLong(redbagId), Long.parseLong(userId));
        } catch (NumberFormatException e) {
            logger.error("查询已领取红包数据异常");
        }
        if (receiveRedbag != null) {
            response.put("command", ServerCommandEnum.S_RECEIVE_REDBAG.getKey());
            JSONObject contentResponse = new JSONObject();
            contentResponse.put("redbagId", redbagId);
            contentResponse.put("amount", receiveRedbag.getAmount());
            contentResponse.put("sendName", receiveRedbag.getSendUserName());
            response.put("content", contentResponse);
            channel.writeAndFlush(new TextWebSocketFrame(response.toJSONString()));
            return;
        }
        try {
            receiveRedbag = receiveRedbagManager.receiveRedbag(domain, Long.parseLong(redbagId), Long.parseLong(userId));
        } catch (Exception e) {
            logger.error("领取红包异常");
        }
        if (receiveRedbag == null) {
            response.put("command", ServerCommandEnum.S_REDBAG_OUT.getKey());
            channel.writeAndFlush(new TextWebSocketFrame(response.toJSONString()));
        }
        response.put("command", ServerCommandEnum.S_RECEIVE_REDBAG.getKey());
        JSONObject contentResponse = new JSONObject();
        contentResponse.put("redbagId", redbagId);
        contentResponse.put("amount", receiveRedbag.getAmount());
        contentResponse.put("sendName", receiveRedbag.getSendUserName());
        response.put("content", contentResponse);
        sendRoomMsg(domain, roomId, response.toJSONString());
        return;
    }

    /**
     * 组装基本返回信息
     *
     * @param userId
     * @param userName
     * @param userIcon
     * @param roleName
     * @return
     */
    private JSONObject createResponse(String userId, String userName, String userIcon, String roleName) {
        JSONObject response = new JSONObject();
        response.put("messageId", UUID.randomUUID().toString().replace("-", ""));
        response.put("userId", userId);
        response.put("userName", userName);
        response.put("userIcon", userIcon);
        response.put("roleName", roleName);
        response.put("messageTime", DateUtils.getStrFromDate(new Date(), "HH:mm:ss"));
        return response;
    }

    /**
     * 发送消息
     *
     * @param domain
     * @param roomId
     * @param response
     */
    public void sendRoomMsg(String domain, String roomId, String response) {
        Map<String, ChannelContextMap> channelMap = DomainChannelMap.sendRoomMsg(domain, roomId);
        if (channelMap != null && channelMap.size() > 0) {
            for (String key : channelMap.keySet()) {
                try {
                    threadPoolTaskExecutor.execute(new SendMsgThread(channelMap.get(key), response));
                } catch (Exception e) {
                }
            }
        }
    }
}
