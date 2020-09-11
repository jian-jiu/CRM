package com.simple.crm.settings.web.controller.user;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.webutil.CookieUtils;
import com.simple.crm.commons.utils.otherutil.IpUtils;
import com.simple.crm.commons.utils.otherutil.Md5Util;
import com.simple.crm.settings.service.user.UserService;
import com.simple.crm.settings.web.exception.LoginException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 用户操作
 *
 * @author 简单
 * @date 2020/7/31 21:10
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/settings/qx/user/")
public class UserController {

    private final UserService userService;

    private final HttpServletResponse response;
    private final HttpSession session;

    /**
     * 跳转到登入界面
     *
     * @return 登入视图
     */
    @RequestMapping("toLogin")
    public ModelAndView toLogin(ModelAndView modelAndView, HttpServletRequest request) {
        modelAndView.setViewName("settings/qx/user/login");
        String ipAddress = IpUtils.getIpAddress(request);
        modelAndView.addObject("ip", ipAddress);
        return modelAndView;
    }

    /**
     * 用户登入
     *
     * @param loginName 登入名
     * @param loginPwd  登入密码
     * @param autoLogin 免登入
     * @return 结果集
     */
    @RequestMapping("login")
    public Object login(@RequestParam() String loginName, String loginPwd, String autoLogin) throws LoginException {
        ReturnObject returnObject = new ReturnObject();
        //调用方法，查询用户
        userService.findUserByLogin(loginName, loginPwd, autoLogin);
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        return returnObject;
    }

    /**
     * 退出登入
     *
     * @return 登入视图
     */
    @RequestMapping("logout")
    public ModelAndView logout(ModelAndView modelAndView) {
        //清空cookie
        CookieUtils.closeCookie(response);
        //使该会话无效
        session.invalidate();
        modelAndView.setViewName("redirect:/");
        return modelAndView;
    }

    /**
     * 修改密码
     *
     * @param id     用户id
     * @param oldPwd 原密码
     * @param newPwd 新密码
     * @return 结果集
     */
    @RequestMapping("/editUserPassword")
    public Object editUserPassword(@RequestParam() String id, String oldPwd, String newPwd) {
        ReturnObject returnObject = new ReturnObject();

        String md5OldPwd = Md5Util.getMd5(oldPwd);
        if (md5OldPwd.equals(userService.findUserPasswordById(id))) {
            String md5NewPwd = Md5Util.getMd5(newPwd);
            int i = userService.modifyUserPasswordById(id, md5NewPwd);
            if (i > 0) {
                Cookie cookie = new Cookie("loginPwd", "0");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
                //使该会话无效
                session.invalidate();

                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("修改失败");
            }
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("原密码不正确");
        }
        return returnObject;
    }
}
