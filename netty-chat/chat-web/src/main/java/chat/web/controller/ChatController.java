package chat.web.controller;

import com.shuangying.core.common.domain.AppConfig;
import com.shuangying.core.common.domain.ManagerException;
import com.shuangying.core.common.domain.PageResult;
import com.shuangying.core.common.domain.ResultDo;
import com.shuangying.core.common.upload.AliyunOssManager;
import com.shuangying.core.common.utility.DateUtils;
import com.shuangying.core.common.utility.Md5Manager;
import com.shuangying.core.db.manager.ReceiveRedbagManager;
import com.shuangying.core.db.manager.RoomManager;
import com.shuangying.core.db.manager.SystemDictManager;
import com.shuangying.core.db.manager.UserManager;
import com.shuangying.core.db.model.DomainConfig;
import com.shuangying.core.db.model.ReceiveRedbag;
import com.shuangying.core.db.model.Room;
import com.shuangying.core.db.model.SystemDict;
import com.shuangying.core.db.model.User;
import com.shuangying.core.db.model.dto.UserInfoDto;
import com.shuangying.core.db.model.query.ReceiveRedBagQuery;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @auther a-de
 * @date 2018/11/12 12:30
 */
@Controller
@RequestMapping(value = "/chat")
public class ChatController extends BaseController {
    private Logger logger = LoggerFactory.getLogger(ChatController.class);
    @Autowired
    private RoomManager roomManager;

    @Autowired
    private UserManager userManager;

    @Autowired
    private ReceiveRedbagManager receiveRedbagManager;

    @Autowired
    private SystemDictManager systemDictManager;

    @Autowired
    private MultipartResolver multipartResolver;

    @RequestMapping(value = "/demo")
    public String demo(HttpServletRequest req, Model model, String token, Long roomId){
        DomainConfig domainConfig = getDomainConfig();
        String websocket = domainConfig.getWebsocketUrl();
        model.addAttribute("token", token);
        model.addAttribute("domain", domainConfig.getDomainName());
        Room room = null;
        room = roomManager.queryByIdAndDomainId(roomId,domainConfig.getId());
        if (room == null) {
            room = roomManager.queryDefaultRoom(domainConfig.getId());
        }
        if (room == null) {
            throw new ManagerException("房间数据有误");
        }
        if (StringUtils.isEmpty(room.getWebsocketUrl())) {
            model.addAttribute("websocket", websocket);
        } else {
            model.addAttribute("websocket", room.getWebsocketUrl());
        }
        model.addAttribute("roomId", room.getId());
        return "/chat/demo";
    }

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest req, Model model, @RequestParam(value = "roomId",defaultValue = "0") Long roomId) {
        DomainConfig domainConfig = getDomainConfig();
        Room room = null;
        if (roomId>0){
            room = roomManager.queryByIdAndDomainId(roomId,domainConfig.getId());
            if (room == null) {
                model.addAttribute("msg","房间不存在");
                return "/chat/error";
            }
            if (room.getOpenRoom()==2){
                User user = getUserInfo(domainConfig.getId());
                if (user == null){
                    model.addAttribute("msg","没有权限进入该房间");
                    return "/chat/error";
                }
                if (!user.getRoomId().equals(room.getId())){
                    model.addAttribute("msg","没有权限进入该房间");
                    return "/chat/error";
                }
            }
        }else {
            room = roomManager.queryDefaultRoom(domainConfig.getId());
            if (room == null) {
                model.addAttribute("msg","房间数据有误");
                return "/chat/error";
            }
        }
        //房间信息
        model.addAttribute("domainName", domainConfig.getDomainName());
        model.addAttribute("room", room);
        //tab信息
        List<SystemDict> tabmenu = systemDictManager.queryGroupKey(domainConfig.getId(),AppConfig.TabMenu,AppConfig.PcTabMenu);
        model.addAttribute("tabmenu", tabmenu);
        //房间列表
        List<Room> roomList = roomManager.queryList(domainConfig.getId());
        model.addAttribute("roomList", roomList);
        //网站设置信息
        List<SystemDict> webset = systemDictManager.queryGroupAllByDomainId(domainConfig.getId(),AppConfig.WebSet);
        Map<String,String> map = new HashMap<>();
        if (webset!=null && webset.size()>0){
            for (SystemDict r : webset){
                map.put(r.getSysKey(),r.getSysValue());
            }
        }
        model.addAttribute("websetmap", map);
        return "/chat/index";
    }

    @RequestMapping(value = "/mIndex")
    public String mIndex(HttpServletRequest req, Model model, @RequestParam(value = "roomId",defaultValue = "0") Long roomId) {
        DomainConfig domainConfig = getDomainConfig();
        Room room = null;
        if (roomId>0){
            room = roomManager.queryByIdAndDomainId(roomId,domainConfig.getId());
            if (room == null) {
                model.addAttribute("msg","房间不存在");
                return "/chat/error";
            }
            if (room.getOpenRoom()==2){
                User user = getUserInfo(domainConfig.getId());
                if (user == null){
                    model.addAttribute("msg","没有权限进入房间");
                    return "/chat/error";
                }
                if (!user.getRoomId().equals(room.getId())){
                    model.addAttribute("msg","没有权限进入房间");
                    return "/chat/error";
                }
            }
        }else {
            room = roomManager.queryDefaultRoom(domainConfig.getId());
            if (room == null) {
                model.addAttribute("msg","房间数据有误");
                return "/chat/error";
            }
        }
        //房间信息
        model.addAttribute("domainName", domainConfig.getDomainName());
        model.addAttribute("room", room);
        //tab信息
        List<SystemDict> tabmenu = systemDictManager.queryGroupKey(domainConfig.getId(),AppConfig.TabMenu,AppConfig.MTabMenu);
        model.addAttribute("tabmenu", tabmenu);
        //房间列表信息
        List<Room> roomList = roomManager.queryList(domainConfig.getId());
        model.addAttribute("roomList", roomList);
        //网站设置信息
        List<SystemDict> webset = systemDictManager.queryGroupAllByDomainId(domainConfig.getId(),AppConfig.WebSet);
        Map<String,String> map = new HashMap<>();
        if (webset!=null && webset.size()>0){
            for (SystemDict r : webset){
                map.put(r.getSysKey(),r.getSysValue());
            }
        }
        model.addAttribute("websetmap", map);
        return "/chat/mIndex";
    }

    @RequestMapping(value = "/login")
    public String login() {
        return "/chat/login";
    }

    @RequestMapping(value = "/mlogin")
    public String mlogin(Model model) {
        return "/chat/mlogin";
    }

    @ResponseBody
    @RequestMapping(value = "/logined", method = RequestMethod.POST)
    public ResultDo logined(String username, String password) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        resultDo = userManager.logined(domainConfig.getId(), username, password,false);
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/loginOut", method = RequestMethod.POST)
    public ResultDo loginOut() {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = getUserInfo(domainConfig.getId());
        if (user == null || !domainConfig.getId().equals(user.getDomainId())) {
            resultDo.setSuccess(true);
            return resultDo;
        }
        resultDo.setSuccess(userManager.removeToken(user.getId()));
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/webSocketUrl", method = RequestMethod.POST)
    public ResultDo webSocketUrl() {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        resultDo.setResult(domainConfig.getWebsocketUrl());
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/onlineUser", method = RequestMethod.POST)
    public ResultDo onlineUser(Long roomId) {
        DomainConfig domainConfig = getDomainConfig();
        return userManager.onlineUser(domainConfig.getId(), roomId);
    }

    @RequestMapping(value = "/saveDeskTop")
    public void saveDeskTop(HttpServletResponse response, String title, String url) throws IOException {
        String templateContent = "[InternetShortcut]" + "\n" + "URL= " + url + "";
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(title, "UTF-8") + ".url");
        response.getWriter().write(templateContent);
        response.getWriter().flush();
    }

    @ResponseBody
    @RequestMapping(value = "/ajaxRooms", method = RequestMethod.POST)
    public ResultDo ajaxRoom() {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        List<Room> roomList = roomManager.queryList(domainConfig.getId());
        resultDo.setList(roomList);
        return resultDo;
    }

    //    @UserInfo()
    @ResponseBody
    @RequestMapping(value = "/ajaxReceiveRedBag", method = RequestMethod.POST)
    public ResultDo ajaxReceiveRedBag(String token, ReceiveRedBagQuery postQuery) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        //SysAuthUser sysAuthUser = getUserInfo();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息错误");
            return resultDo;
        }
        ReceiveRedBagQuery query = new ReceiveRedBagQuery();
        query.setDomainId(domainConfig.getId());
        query.setReceiverId(user.getId());
        query.setStartTime(DateUtils.addDate(new Date(),-3));
        query.setiDisplayStart(postQuery.getiDisplayStart());
        query.setiDisplayLength(postQuery.getiDisplayLength());
        PageResult<ReceiveRedbag> list = receiveRedbagManager.queryPage(query);
        resultDo.setResult(list);
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/userInfo", method = RequestMethod.POST)
    public ResultDo userInfo(String token) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        UserInfoDto dto = userManager.queryUserInfo(domainConfig.getId(), token);
        if (dto == null) {
            resultDo.setErrorDesc("登录信息失效");
            return resultDo;
        }
        resultDo.setResult(dto);
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/updateIcon", method = RequestMethod.POST)
    public ResultDo updateIcon(String token, String icon) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息有误");
            return resultDo;
        }
        user.setIcon(icon);
        resultDo.setSuccess(userManager.update(user));
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public ResultDo updatePassword(String token, String oldPassword, String firstPassword, String secondPassword) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息有误");
            return resultDo;
        }
        if (StringUtils.isEmpty(firstPassword) || StringUtils.isEmpty(secondPassword)) {
            resultDo.setErrorDesc("密码不能为空");
            return resultDo;
        }
        if (!firstPassword.equals(secondPassword)) {
            resultDo.setErrorDesc("两次密码不一致");
            return resultDo;
        }
        String p = Md5Manager.md5(oldPassword, user.getSalt());
        if (!user.getPassword().equals(p)) {
            resultDo.setErrorDesc("密码错误");
            return resultDo;
        }
        user.setPassword(Md5Manager.md5(firstPassword, user.getSalt()));
        resultDo.setSuccess(userManager.update(user));
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/uploadTempImg", method = RequestMethod.POST)
    public ResultDo uploadTempImg(HttpServletRequest req, HttpServletResponse resp, String token) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息有误");
            return resultDo;
        }
        MultipartHttpServletRequest multipartRequest = null;
        try {
            if (multipartResolver.isMultipart(req)) {
                multipartRequest = (MultipartHttpServletRequest) req;
                Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
                for (Map.Entry<String, MultipartFile> en : fileMap.entrySet()) {
                    MultipartFile multipartFile = en.getValue();
                    //后缀
                    String fileName = multipartFile.getOriginalFilename();
                    String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
                    String result = AliyunOssManager.uploadTempImg(multipartFile.getInputStream(), suffix);
                    resultDo.setResult(result);
                    return resultDo;
                }
            } else {
                logger.error("无效的上传请求。");
                resultDo.setErrorDesc("无效的上传请求。");
            }
        } catch (IOException e) {
            logger.error("上传文件出现异常。", e);
            resultDo.setErrorDesc("上传文件出现异常。");
        } finally {
            if (multipartRequest != null) {
                multipartResolver.cleanupMultipart(multipartRequest);
            }
        }
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/uploadForeverImg", method = RequestMethod.POST)
    public ResultDo uploadForeverImg(HttpServletRequest req, HttpServletResponse resp, String token) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息有误");
            return resultDo;
        }
        MultipartHttpServletRequest multipartRequest = null;
        try {
            if (multipartResolver.isMultipart(req)) {
                multipartRequest = (MultipartHttpServletRequest) req;
                Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
                for (Map.Entry<String, MultipartFile> en : fileMap.entrySet()) {
                    MultipartFile multipartFile = en.getValue();
                    //后缀
                    String fileName = multipartFile.getOriginalFilename();
                    String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
                    String result = AliyunOssManager.uploadForeverImg(multipartFile.getInputStream(), suffix);
                    resultDo.setResult(result);
                    return resultDo;
                }
            } else {
                logger.error("无效的上传请求。");
                resultDo.setErrorDesc("无效的上传请求。");
            }
        } catch (IOException e) {
            logger.error("上传文件出现异常。", e);
            resultDo.setErrorDesc("上传文件出现异常。");
        } finally {
            if (multipartRequest != null) {
                multipartResolver.cleanupMultipart(multipartRequest);
            }
        }
        return resultDo;
    }

    @ResponseBody
    @RequestMapping(value = "/uploadBaseImg", method = RequestMethod.POST)
    public ResultDo uploadBaseImg(@RequestParam String base64Data, String token) {
        ResultDo resultDo = new ResultDo();
        DomainConfig domainConfig = getDomainConfig();
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), token);
        if (user == null) {
            resultDo.setErrorDesc("登录信息有误");
            return resultDo;
        }
        try {
            String dataPrix = "";
            String data = "";
            if (base64Data == null || "".equals(base64Data)) {
                throw new Exception("上传失败，上传图片数据为空");
            } else {
                String[] d = base64Data.split("base64,");
                if (d != null && d.length == 2) {
                    dataPrix = d[0];
                    data = d[1];
                } else {
                    throw new Exception("上传失败，数据不合法");
                }
            }
            String suffix = "";
            if ("data:image/jpeg;".equalsIgnoreCase(dataPrix)) {//data:image/jpeg;base64,base64编码的jpeg图片数据
                suffix = ".jpg";
            } else if ("data:image/x-icon;".equalsIgnoreCase(dataPrix)) {//data:image/x-icon;base64,base64编码的icon图片数据
                suffix = ".ico";
            } else if ("data:image/gif;".equalsIgnoreCase(dataPrix)) {//data:image/gif;base64,base64编码的gif图片数据
                suffix = ".gif";
            } else if ("data:image/png;".equalsIgnoreCase(dataPrix)) {//data:image/png;base64,base64编码的png图片数据
                suffix = ".png";
            } else {
                throw new Exception("上传图片格式不合法");
            }
            //因为BASE64Decoder的jar问题，此处使用spring框架提供的工具包
            byte[] bs = Base64Utils.decodeFromString(data);
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bs);
            String result = AliyunOssManager.uploadTempImg(byteArrayInputStream, suffix);
            resultDo.setResult(result);
            return resultDo;
        } catch (Exception e) {
            return resultDo;
        }
    }

    @RequestMapping(value = "/404")
    public String error(){
        return "/chat/404";
    }
}
