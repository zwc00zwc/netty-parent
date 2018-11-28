package chat.web.controller;

import chat.web.auth.SysAuthUser;
import com.shuangying.core.common.domain.AppConfig;
import com.shuangying.core.common.domain.ManagerException;
import com.shuangying.core.db.manager.DomainConfigManager;
import com.shuangying.core.db.model.DomainConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.UUID;

import static org.springframework.http.HttpHeaders.HOST;

/**
 * @auther a-de
 * @date 2018/11/6 14:01
 */
public class BaseController {
    @Autowired
    private DomainConfigManager domainConfigManager;
    protected DomainConfig getDomainConfig() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes()).getRequest();

        String domain = request.getHeader(HOST);
        //String domain = request.getServerName() + ":" + request.getServerPort();
        DomainConfig domainConfig = domainConfigManager.queryByDomainName(domain);
        if (domainConfig == null || domainConfig.getStatus() != 1 || new Date().after(domainConfig.getEndTime()) ||
                new Date().before(domainConfig.getStartTime())) {
            throw new ManagerException(AppConfig.DomainError);
        }
        return domainConfig;
    }

    protected String[] getPermsArray(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes()).getRequest();
        if (request.getAttribute("permArray")!=null){
            String[] permArray = (String[]) request.getAttribute("permArray");
            return permArray;
        }
        return null;
    }

    protected SysAuthUser getUserInfo(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes()).getRequest();
        return (SysAuthUser)request.getAttribute("userInfo");
    }

    public static void main(String[] args){
        String aa = UUID.randomUUID().toString().replace("-","");
        System.out.print("aaa:"+aa);
    }

}
