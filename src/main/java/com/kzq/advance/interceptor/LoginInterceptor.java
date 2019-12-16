package com.kzq.advance.interceptor;

import com.kzq.advance.domain.TUser;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;

@Controller
@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {
    protected Logger log = LogManager.getLogger(getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String basePath = request.getContextPath();
        String path = request.getRequestURI();

        HttpSession session = request.getSession();
        if(!doLoginInterceptor(path, basePath) ){//是否进行登陆拦截
            return true;
        }
        // 获取用户信息，如果没有用户信息直接返回提示信息
        TUser userInfo = (TUser) session.getAttribute("user");
        if (userInfo == null) {
            log.info("path:"+path+"  没有登录");
            request.setAttribute("msg","无权限请先登录");


        }else {

            request.removeAttribute("msg");

        }
        return true;

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {

    }
    /**
     * 是否进行登陆过滤
     * @param path
     * @param basePath
     * @return
     */
    private boolean doLoginInterceptor(String path,String basePath){
        path = path.substring(basePath.length());
        Set<String> notLoginPaths = new HashSet<>();
        //设置不进行登录拦截的路径：登录注册和验证码
        notLoginPaths.add("/wx/login");
        notLoginPaths.add("/");
        notLoginPaths.add("/style/");
        notLoginPaths.add("/js/");


        if(notLoginPaths.contains(path))
            return false;
        return true;
    }
}
