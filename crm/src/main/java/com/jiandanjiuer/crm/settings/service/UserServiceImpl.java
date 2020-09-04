package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.utils.otherutil.DateUtils;
import com.jiandanjiuer.crm.commons.utils.otherutil.IpUtils;
import com.jiandanjiuer.crm.commons.utils.otherutil.Md5Util;
import com.jiandanjiuer.crm.commons.utils.webutil.CookieUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.mapper.UserMapper;
import com.jiandanjiuer.crm.settings.web.exception.LoginException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 业务层用户实现类
 *
 * @author 简单
 * @date 2020/8/4 9:08
 */
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private final HttpSession session;

    /**
     * 查询用户是否存在
     *
     * @param map
     * @return
     */
    @Override
    public User queryUserByLoginAndPwd(Map<String, Object> map) {
        return userMapper.selectUserByLoginActAndPwd(map);
    }

    /**
     * 根据登入名查询用户，并且进行登入判断
     *
     * @param loginName 登入名
     * @param loginPwd  MD5加密密码
     * @param autoLogin 是否保存用户名和密码
     * @return User对象
     * @throws LoginException 登入异常
     */
    @Override
    public User findUserByLogin(String loginName, String loginPwd, String autoLogin) throws LoginException {
        //查询用户
        User user = userMapper.selectUserByLoginName(loginName);
        if (user == null) {
            throw new LoginException("用户名不存在");
        }

        String md5Pwd = "";
        if (user.getLoginPwd().equals(loginPwd)) {
            md5Pwd = loginPwd;
        } else {
            //密码进行MD5加密
            md5Pwd = Md5Util.getMd5(loginPwd);
            if (!user.getLoginPwd().equals(md5Pwd)) {
                throw new LoginException("密码错误");
            }
        }
        System.out.println("====" + user.getAllowIps().contains("*"));
        //判断用户
        if (DateUtils.formatDateTime(new Date()).compareTo(user.getExpireTime()) > 0) {
            throw new LoginException("账号已经过期");
        } else if ("0".equals(user.getLockState())) {
            throw new LoginException("账号被锁定");
        } else if (user.getAllowIps().contains("*")) {

        } else if (!user.getAllowIps().contains(IpUtils.getIpAddress(request))) {
            throw new LoginException("ip受限");
        }
        //把用户信息保存到session中
        session.setAttribute(Contents.SESSION_USER, user);
        //是否免登入
        Cookie cookie;
        if ("true".equals(autoLogin)) {
            //设置登入名
            cookie = new Cookie("loginAct", loginName);
            cookie.setMaxAge(60 * 60 * 24 * 10);
            cookie.setPath("/");
            response.addCookie(cookie);
            //设置登入密码
            cookie = new Cookie("loginPwd", md5Pwd);
            cookie.setMaxAge(60 * 60 * 24 * 10);
            cookie.setPath("/");
            response.addCookie(cookie);
        } else {
            //清空cookie
            CookieUtils.closeCookie(response);
        }
        return user;
    }

    /**
     * 查询所有的用户
     *
     * @return
     */
    @Override
    public List<User> queryAllUsers() {
        return userMapper.selectAllUsers();
    }

    /**
     * 查询用户密码
     *
     * @param id
     * @return
     */
    @Override
    public String findUserPasswordById(String id) {
        return userMapper.selectUserPasswordById(id);
    }

    /**
     * 根据id查询用户
     *
     * @param id 用户id
     * @return 用户对象
     */
    @Override
    public User findUserById(String id) {
        return userMapper.selectUserById(id);
    }


    /**
     * 根据id修改用户密码
     *
     * @param id
     * @param newPwd
     * @return
     */
    @Override
    public int modifyUserPasswordById(String id, String newPwd) {
        return userMapper.updateUserPasswordById(id, newPwd);
    }
}
