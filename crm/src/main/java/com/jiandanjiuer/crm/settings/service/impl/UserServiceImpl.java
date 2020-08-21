package com.jiandanjiuer.crm.settings.service.impl;

import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.mapper.UserMapper;
import com.jiandanjiuer.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 业务层用户实现类
 *
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
     * 查询所有的用户
     *
     * @return
     */
    @Override
    public List<User> queryAllUsers() {
        return userMapper.selectAllUsers();
    }
}
