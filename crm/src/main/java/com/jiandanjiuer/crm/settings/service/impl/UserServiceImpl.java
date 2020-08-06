package com.jiandanjiuer.crm.settings.service.impl;

import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.mapper.UserMapper;
import com.jiandanjiuer.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/4 9:08
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    /**
     * 注入实现类
     */
    @Autowired
    private UserMapper userMapper;

    @Override
    public User queryUserByLoginAndPwd(Map<String, Object> map) {
        return userMapper.selectUserByLoginActAndPwd(map);
    }
}
