package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.User;

import java.util.Map;

/**
 * @author: 简单
 * @date: 2020/8/4 9:05
 */
public interface UserService {
    /**
     *查询用户登入
     * @param map
     * @return
     */
    User queryUserByLoginAndPwd(Map<String,Object> map);
}
