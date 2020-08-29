package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.User;

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
     * 查询所有的用户
     *
     * @return
     */
    List<User> queryAllUsers();

    /**
     * 根据id查询用户密码
     *
     * @param id
     * @return
     */
    String findUserPasswordById(String id);

    /**
     * 根据id修改用户密码
     *
     * @param id
     * @param newPwd
     * @return
     */
    int modifyUserPasswordById(String id, String newPwd);
}
