package com.simple.crm.settings.web.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.IpUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.settings.service.user.UserService;
import com.simple.crm.settings.web.exception.LoginException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * 用户登入请求拦截器
 *
 * @author 简单
 * @date 2020/8/6 19:24
 */
@RequiredArgsConstructor
public class LoginInterceptor implements HandlerInterceptor {

    private final UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获取用户ip
        System.out.println("用户ip：" + IpUtils.getIpAddress(httpServletRequest));
        //登入验证
        HttpSession session = httpServletRequest.getSession();
        User sessionUser = (User) session.getAttribute(Contents.SESSION_USER);
        if (sessionUser == null) {
            //判断是否是ajax请求
            if (httpServletRequest.getHeader("X-Requested-With") != null) {
                ReturnObject returnObject = new ReturnObject();
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
//                httpServletRequest.setCharacterEncoding("utf-8");
                httpServletResponse.setContentType("application/json;charset=UTF-8");
                returnObject.setMessage("登入超时,请重新登入");
                returnObject.setData("转发到登入界面");
                try {
                    ObjectMapper objectMapper = new ObjectMapper();
                    String s = objectMapper.writeValueAsString(returnObject);
                    httpServletResponse.getWriter().write(s);
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
                return false;
            }
            //跳转登入界面
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath());
            return false;
        }
        //判断用户是否合法
        User user = userService.findUserById(sessionUser.getId());
        if (!(sessionUser.getLoginPwd().equals(user.getLoginPwd()))) {
            throw new Exception("密码已经修改");
        } else if (DateUtils.formatDateTime(new Date()).compareTo(user.getExpireTime()) > 0) {
            throw new Exception("账号已经过期");
        } else if ("0".equals(user.getLockState())) {
            throw new Exception("账号被锁定");
        } else if (user.getAllowIps().contains("*")) {

        } else if (!user.getAllowIps().contains(IpUtils.getIpAddress(httpServletRequest))) {
            throw new LoginException("ip受限");
        }
        return true;
    }
}
