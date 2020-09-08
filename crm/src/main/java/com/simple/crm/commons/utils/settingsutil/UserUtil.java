package com.simple.crm.commons.utils.settingsutil;

import com.simple.crm.settings.domain.User;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/4
 */
public class UserUtil {

    /**
     * 查询传过来的用户id
     *
     * @param users    用户list集合
     * @param username 查询用户名
     * @return 用户id
     */
    public static String getUserId(List<User> users, String username) {
        for (User user : users) {
            if (username.equals(user.getName())) {
                return user.getId();
            }
        }
        return null;
    }
}
