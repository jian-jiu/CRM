package com.jiandanjiuer.crm.settings.mapper;

import com.jiandanjiuer.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

/**
 * 用户mapper接口
 *
 * @author 24245
 */
public interface UserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    User selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_user
     *
     * @mbggenerated Mon Aug 03 21:21:46 CST 2020
     */
    int updateByPrimaryKey(User record);

    /**
     * 根据用户名和密码查询用户
     *
     * @param map
     * @return
     */
    User selectUserByLoginActAndPwd(Map<String, Object> map);

    /**
     * 查询所有的用户
     * @return
     */
    List<User> selectAllUsers();

}