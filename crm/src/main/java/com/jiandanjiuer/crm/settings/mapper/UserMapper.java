package com.jiandanjiuer.crm.settings.mapper;

import com.jiandanjiuer.crm.settings.domain.User;
import org.apache.ibatis.annotations.Param;

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
     * 根据登入名和密码查询用户
     *
     * @param map
     * @return
     */
    User selectUserByLoginActAndPwd(Map<String, Object> map);

    /**
     * 查询所有的用户
     *
     * @return
     */
    List<User> selectAllUsers();

    /**
     * 根据id查询用户密码
     *
     * @param id
     * @return
     */
    String selectUserPasswordById(String id);

    /**
     * 根据id修改用户密码
     *
     * @param id
     * @param newPwd
     * @return
     */
    int updateUserPasswordById(String id, String newPwd);
}