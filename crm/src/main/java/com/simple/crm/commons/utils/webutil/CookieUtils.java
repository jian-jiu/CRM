package com.simple.crm.commons.utils.webutil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

/**
 * cookie工具类
 *
 * @author 简单
 * @date 2020/9/3
 */
public class CookieUtils {

    /**
     * 清空cookie
     *
     * @param response 响应
     */
    public static void closeCookie(HttpServletResponse response) {
        //清空账号
        Cookie cookie;
        cookie = new Cookie("loginAct", "0");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        //清空密码
        cookie = new Cookie("loginPwd", "0");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
