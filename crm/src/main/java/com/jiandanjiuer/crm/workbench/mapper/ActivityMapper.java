package com.jiandanjiuer.crm.workbench.mapper;

import com.jiandanjiuer.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    int insert(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    int insertSelective(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    Activity selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    int updateByPrimaryKeySelective(Activity record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity
     *
     * @mbggenerated Mon Aug 17 09:49:36 CST 2020
     */
    int updateByPrimaryKey(Activity record);


    /**
     * 根据条件分页查询数据
     *
     * @param map 需要map
     * @return 返回分页的所有市场活动集合
     */
    List<Activity> selectActivityForPageByCondition(Map<String, Object> map);

    /**
     * 查询详细的所有市场活动
     *
     * @return 详细市场活动集合
     */
    List<Activity> selectActivityForDetail();

    /**
     * 根据多个id查询详细的所有市场活动
     *
     * @param ids id数组
     * @return 详细市场活动集合
     */
    List<Activity> selectActivityForDetailByIds(String[] ids);

    /**
     * 根据条件查询总条数
     *
     * @param map map
     * @return 总条数
     */
    long selectCountOActivityByCondition(Map<String, Object> map);


    /**
     * 保存创建的市场活动
     *
     * @param activity 市场活动对象
     * @return 添加条数
     */
    int insertActivity(Activity activity);

    /**
     * 保存创建的多个市场活动
     *
     * @param activity 市场活动对象
     * @return 添加成功条数
     */
    int insertActivityByList(List<Activity> activity);


    /**
     * 修改数据
     *
     * @param activity 市场活动对象
     * @return 修改条数
     */
    int updateByPrimaryId(Activity activity);


    /**
     * 根据多个id删除数据
     *
     * @param ids id数组
     * @return 删除条数
     */
    int deleteActivityByIds(String[] ids);


}