package com.simple.crm.workbench.mapper.activity;

import com.simple.crm.workbench.domain.activity.ActivityRemark;

import java.util.List;

/**
 * 市场活动备注mapper
 *
 * @author 24245
 */
public interface ActivityRemarkMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    int insert(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    int insertSelective(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    ActivityRemark selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    int updateByPrimaryKeySelective(ActivityRemark record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_activity_remark
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    int updateByPrimaryKey(ActivityRemark record);

    /**
     * 根据市场活动id查询市场活动备注
     *
     * @param id 市场活动id
     * @return 市场活动备注list集合
     */
    List<ActivityRemark> selectActivityRemarkForDetailByActivityId(String id);

    /**
     * 根据市场活动备注id查询详细的市场活动
     * @param id id
     * @return 市场活动备注对象
     */
    ActivityRemark selectActivityRemarkForDetailById(String id);


    /**
     * 修改市场活动备注
     *
     * @param activityRemark 市场活动备注对象
     * @return 修改条数
     */
    int updateActivityRemarkById(ActivityRemark activityRemark);


    /**
     * 根据多个市场活动id删除市场活动备注
     *
     * @param ids 市场活动ids
     * @return 删除添数
     */
    int deleteActivityRemarkByActivityIds(String[] ids);


}