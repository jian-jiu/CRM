package com.jiandanjiuer.crm.settings.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.DateUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户操作
 *
 * @author 简单
 * @date 2020/7/31 21:10
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    private Cookie cookie;

    /**
     * 跳转到登入界面
     *
     * @return
     */
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    /**
     * 用户登入
     *
     * @param loginAct
     * @param loginPwd
     * @param isRemPew
     * @param request
     * @return
     */
    @RequestMapping("/settings/qx/user/login.do")
    public @ResponseBody
    Object login(String loginAct, String loginPwd, String isRemPew,
                 HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        ReturnObject returnObject = new ReturnObject();
        if (loginAct != null && loginPwd != null) {
            //封装参数
            Map<String, Object> map = new HashMap<>(2);
            map.put("loginAct", loginAct);
            map.put("loginPwd", loginPwd);

            //调用方法，查询用户
            User user = userService.queryUserByLoginAndPwd(map);

            //根据查询结果,生成响应信息
            if (user == null) {
                //用户名或者密码错误,登入失败
                //code = 0 ,message = "用户名或者密码错误"
                returnObject.setMessage("用户名或者密码错误");
            } else {
                if (DateUtils.formatDateTime(new Date()).compareTo(user.getExpireTime()) > 0) {
                    //账号已经过期,登入失败
                    //code = 0 ,message = "账号已经过期"
                    returnObject.setMessage("账号已经过期");

                } else if ("0".equals(user.getLockState())) {
                    //账号被锁定，登入失败
                    //code = 0 ,message = "账号被锁定"
                    returnObject.setMessage("账号被锁定");

                } else if (!user.getAllowIps().contains(request.getRemoteAddr())) {
                    //ip受限,登入失败
                    //code = 0 ,message = "ip受限"
                    returnObject.setMessage("ip受限");

                } else {
                    //登入成功
                    //code = 1
                    returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);

                    //把用户信息保存到session中
                    session.setAttribute(Contents.SESSION_USER, user);

                    if ("true".equals(isRemPew)) {
                        cookie = new Cookie("loginAct", loginAct);
                        cookie.setMaxAge(60 * 60 * 24 * 10);
                        response.addCookie(cookie);

                        cookie = new Cookie("loginPwd", loginPwd);
                        cookie.setMaxAge(60 * 60 * 24 * 10);

                    } else {
                        cookie = new Cookie("loginAct", "0");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);

                        cookie = new Cookie("loginPwd", "0");
                        cookie.setMaxAge(0);
                    }
                    response.addCookie(cookie);
                }
            }
        } else {
            returnObject.setMessage("用户名或者密码错误");
        }
        return returnObject;
    }

    /**
     * 退出登入
     *
     * @param response
     * @param session
     * @return
     */
    @RequestMapping("/settings/qx/user/logout.do")
    public String logout(HttpServletResponse response, HttpSession session) {
        System.out.println("==========================================");
        cookie = new Cookie("loginAct", "0");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        cookie = new Cookie("loginPwd", "0");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        session.invalidate();

        return "redirect:/";
    }
}
