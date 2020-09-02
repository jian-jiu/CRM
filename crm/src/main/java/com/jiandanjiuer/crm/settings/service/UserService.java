package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.web.exception.LoginException;

import java.util.List;
import java.util.Map;

/**
 * 用户层用户接口
 *
 * @author 简单
 * @date 2020/8/4 9:05
 */
public interface UserService {
    /**
     * 根据登录名和密码查询用户
     *
     * @param map
     * @return
     */
    User queryUserByLoginAndPwd(Map<String, Object> map);

    /**
     * 根据登入名查询用户，并且进行登入判断
     *
     * @param loginName 登入名
     * @param loginPwd  MD5加密密码
     * @return User对象
     */
    User findUserByLogin(String loginName, String loginPwd, String autoLogin) throws LoginException;

    /**
     * 查询所有的用户
     *
     * @return
     */
    List<User> queryAllUsers();

    /**
     * 根据id查询用户密码
     *
     * @param id 用户id
     * @return 用户对象
     */
    String findUserPasswordById(String id);

    /**
     * 根据id查询用户
     *
     * @param id 用户id
     * @return 用户对象
     */
    User findUserById(String id);


    /**
     * 根据id修改用户密码
     *
     * @param id
     * @param newPwd
     * @return
     */
    int modifyUserPasswordById(String id, String newPwd);
}
