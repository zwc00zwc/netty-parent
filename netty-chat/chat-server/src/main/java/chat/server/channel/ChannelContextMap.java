package chat.server.channel;

import chat.server.command.ServerCommandEnum;
import com.alibaba.fastjson.JSONObject;
import com.shuangying.core.common.utility.DateUtils;
import io.netty.channel.Channel;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import io.netty.util.Attribute;
import io.netty.util.AttributeKey;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @auther a-de
 * @date 2018/11/5 15:15
 */
public class ChannelContextMap {
    private Map<String,ChannelContext> contextMap;

    private AttributeKey<NettyChannelInfo> infoKey = AttributeKey.valueOf("channelInfo");

    public ChannelContextMap(){
        contextMap = new ConcurrentHashMap<>();
    }

    /**
     * 添加channel上下文
     * @param ip IP
     * @param userId
     * @param token
     * @param channel
     */
    public void addChannelContext(String domain,String roomId,String zoneKey,String ip,Long userId,String token, Channel channel) {
        ChannelContext channelContext = null;
        String key = null;
        if (StringUtils.isEmpty(token)){
            key = ip;
        }else {
            key = token;
        }
        if (contextMap.containsKey(key)) {
            channelContext = contextMap.get(key);
            if (channelContext != null && channelContext.getChannel() != null) {
                channelContext.getChannel().close();
            }
        }
        channelContext = new ChannelContext();
        channelContext.setDomain(domain);
        channelContext.setRoomId(roomId);
        channelContext.setIp(ip);
        channelContext.setUserId(userId);
        channelContext.setToken(token);
        channelContext.setChannel(channel);
        Attribute<NettyChannelInfo> attribute = channel.attr(infoKey);
        if (attribute.get()==null){
            NettyChannelInfo nettyChannelInfo = new NettyChannelInfo();
            nettyChannelInfo.setDomain(domain);
            nettyChannelInfo.setRoomId(roomId);
            nettyChannelInfo.setZoneKey(zoneKey);
            nettyChannelInfo.setContextKey(key);
            attribute.set(nettyChannelInfo);
        }
        contextMap.put(key, channelContext);
    }

    /**
     * 检查是否存在token
     * @param token
     * @return
     */
    public boolean checkToken(String token){
        if (contextMap.containsKey(token)){
            return true;
        }
        return false;
    }

    /**
     * 移除channel上下文
     * @param ip
     */
    public void removeChannelContext(String ip,String token) {
        String key = null;
        if (StringUtils.isEmpty(token)){
            key = ip;
        }else {
            key = token;
        }
        ChannelContext channelContext = null;
        if (contextMap.containsKey(key)) {
            channelContext = contextMap.get(ip);
            contextMap.remove(ip);
        }
        if (channelContext != null && channelContext.getChannel() != null) {
            channelContext.getChannel().close();
        }
    }

    /**
     * 移除用户channel上下文
     * @param userId
     */
    public void removeUserIdChannelContext(Long userId){
        if (contextMap!=null && contextMap.size()>0){
            Iterator<Map.Entry<String, ChannelContext>> it = contextMap.entrySet().iterator();
            while (it.hasNext()){
                try {
                    Map.Entry<String, ChannelContext> entry= it.next();
                    if (entry.getValue()!=null && userId == entry.getValue().getUserId()){
                        if (entry.getValue().getChannel()!=null){
                            entry.getValue().getChannel().close();
                        }
                        it.remove();
                    }
                } catch (Exception e) {

                }
            }
        }
    }

    /**
     * 获取并移除用户channel上下文
     * @param userId
     */
    public List<ChannelContext> getAndRemoveUserIdChannelContext(Long userId){
        List<ChannelContext> list = new ArrayList<>();
        if (contextMap!=null && contextMap.size()>0){
            Iterator<Map.Entry<String, ChannelContext>> it = contextMap.entrySet().iterator();
            while (it.hasNext()){
                try {
                    Map.Entry<String, ChannelContext> entry= it.next();
                    if (entry.getValue()!=null && userId == entry.getValue().getUserId()){
                        list.add(entry.getValue());
                        it.remove();
                    }
                } catch (Exception e) {

                }
            }
        }
        return list;
    }

    /**
     * 移除未登录ip channel上下文
     * @param ip
     */
    public void removeIpChannelContext(String ip){
        if (contextMap!=null && contextMap.size()>0){
            ChannelContext channelContext = null;
            Iterator<Map.Entry<String, ChannelContext>> it = contextMap.entrySet().iterator();
            while (it.hasNext()){
                try {
                    Map.Entry<String, ChannelContext> entry= it.next();
                    if (entry.getValue()!=null && ip.equals(channelContext.getIp()) && StringUtils.isEmpty(channelContext.getToken())){
                        if (entry.getValue().getChannel()!=null){
                            if (entry.getValue().getChannel().isActive()){
                                JSONObject response = new JSONObject();
                                response.put("messageId", UUID.randomUUID().toString().replace("-", ""));
                                response.put("command", ServerCommandEnum.S_IP_ERROR.getKey());
                                response.put("messageTime", DateUtils.getStrFromDate(new Date(), "HH:mm:ss"));
                                entry.getValue().getChannel().writeAndFlush(new TextWebSocketFrame(response.toJSONString()));
                            }
                            entry.getValue().getChannel().close();
                        }
                        it.remove();
                    }
                } catch (Exception e) {
                }
            }
        }
    }

    /**
     * 移除所有channel上下文
     */
    public void removeAllChannelContext(){
        if (contextMap!=null && contextMap.size()>0){
            Iterator<Map.Entry<String, ChannelContext>> it = contextMap.entrySet().iterator();
            while (it.hasNext()){
                try {
                    Map.Entry<String, ChannelContext> entry= it.next();
                    if (entry.getValue()!=null && entry.getValue().getChannel()!=null){
                        entry.getValue().getChannel().close();
                    }
                    it.remove();
                } catch (Exception e) {

                }
            }
        }
    }

    /**
     * 清理Channel上下文
     */
    public void cleanChannelContext(){
        if (contextMap!=null && contextMap.size()>0){
            Iterator<Map.Entry<String, ChannelContext>> it = contextMap.entrySet().iterator();
            while (it.hasNext()){
                try {
                    Map.Entry<String, ChannelContext> entry= it.next();
                    if (entry.getValue()==null || entry.getValue().getChannel()==null || !entry.getValue().getChannel().isActive()){
                        if (entry.getValue().getChannel()!=null){
                            entry.getValue().getChannel().close();
                        }
                        it.remove();
                    }
                } catch (Exception e) {

                }
            }
        }
    }

    public ChannelContext getAndRemoveSingleChannelContext(String contextKey){
        ChannelContext context = null;
        if (contextMap!=null && contextMap.size()>0){
            if (contextMap.containsKey(contextKey)){
                context = contextMap.get(contextKey);
                contextMap.remove(contextKey);
                return context;
            }
        }
        return null;
    }

    /**
     * 监控在线数
     * @return
     */
    public Integer monitorOnline() {
        if (contextMap != null && contextMap.size() > 0) {
            return contextMap.size();
        }
        return 0;
    }

    /**
     * 发送所有
     * @param msg
     */
    public void sendAll(String msg){
        if (contextMap!=null && contextMap.size()>0){
            ChannelContext channelContext = null;
            for (String key : contextMap.keySet()){
                try {
                    channelContext = contextMap.get(key);
                    if (channelContext!=null && channelContext.getChannel()!=null && channelContext.getChannel().isActive()){
                        channelContext.getChannel().writeAndFlush(new TextWebSocketFrame(msg));
                    }
                } catch (Exception e) {
                }
            }
        }
    }
}
