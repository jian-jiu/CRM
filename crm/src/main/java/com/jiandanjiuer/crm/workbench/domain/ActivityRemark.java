package com.jiandanjiuer.crm.workbench.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 市场活动备注实体类
 *
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ActivityRemark {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.id
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.note_content
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String noteContent;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.create_time
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.create_by
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String createBy;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.edit_time
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String editTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.edit_by
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String editBy;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.edit_flag
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String editFlag;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_activity_remark.activity_id
     *
     * @mbggenerated Fri Sep 04 08:45:19 CST 2020
     */
    private String activityId;
}