package chat.web.auth;

import chat.web.exception.SysAuthException;
import com.shuangying.core.common.domain.Constants;
import com.shuangying.core.db.manager.DomainConfigManager;
import com.shuangying.core.db.manager.RoleManager;
import com.shuangying.core.db.manager.UserManager;
import com.shuangying.core.db.model.DomainConfig;
import com.shuangying.core.db.model.Permission;
import com.shuangying.core.db.model.User;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

import static org.springframework.http.HttpHeaders.HOST;

/**
 * @auther a-de
 * @date 2018/11/6 13:58
 */
@Aspect
@Component
public class SysAuthService {
    @Autowired
    private UserManager userManager;

    @Autowired
    private DomainConfigManager domainConfigManager;

    @Autowired
    private RoleManager roleManager;

    @Pointcut("@annotation(chat.web.auth.SysAuth)")
    public void methodPointcut(){

    }

    @Before("@annotation(sysAuth)")
    public void before(SysAuth sysAuth) throws SysAuthException {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = requestAttributes.getRequest();
        Cookie cookie = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                if (Constants.CHAT_USER_TOKEN.equals(cookies[i].getName())) {
                    cookie = cookies[i];
                }
            }
        }
        if (cookie == null) {
            throw new SysAuthException("未登陆");
        }
        String domain = request.getHeader(HOST);
        DomainConfig domainConfig = domainConfigManager.queryByDomainName(domain);
        if (domainConfig == null) {
            throw new SysAuthException("域名未开通");
        }
        User user = userManager.queryByDomainIdAndToken(domainConfig.getId(), cookie.getValue());
        if (user == null) {
            throw new SysAuthException("未登录");
        }

        List<Permission> perms = roleManager.queryRoleAllPerms(user.getRoleId());
        String[] permArray = new String[perms.size()];

        boolean isAuth = false;
        if (StringUtils.isEmpty(sysAuth.rule())) {
            isAuth = true;
        }else {
            if (perms != null && perms.size() > 0) {
                for (int i = 0; i < perms.size(); i++) {
                    permArray[i] = perms.get(i).getAuthority();
                    if (!StringUtils.isEmpty(sysAuth.rule())){
                        if (sysAuth.rule().equals(perms.get(i).getAuthority())) {
                            isAuth = true;
                        }
                    }
                }
            }
        }

        if (!isAuth) {
            throw new SysAuthException("没有权限");
        }

        SysAuthUser sysAuthUser = new SysAuthUser();
        sysAuthUser.setUserId(user.getId());
        sysAuthUser.setUserName(user.getUserName());
        sysAuthUser.setRoleId(user.getRoleId());
        sysAuthUser.setStatus(user.getStatus());
        sysAuthUser.setToken(user.getToken());
        request.setAttribute("userInfo",sysAuthUser);
        request.setAttribute("permArray",permArray);
    }
}
