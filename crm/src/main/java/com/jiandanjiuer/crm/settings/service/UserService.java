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
     * 查询用户登入
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
}
