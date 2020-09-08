package com.jiandanjiuer.crm.workbench.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 线索实体类
 *
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Clue implements Serializable {
    /**
     * id
     */
    private String id;

    /**
     * 姓名
     */
    private String fullName;

    /**
     * 称呼
     */
    private String appellation;

    /**
     * 所有者
     */
    private String owner;

    /**
     * 公司
     */
    private String company;

    /**
     * 职位
     */
    private String job;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 公司电话
     */
    private String phone;

    /**
     * 公司网站
     */
    private String website;

    /**
     * 个人电话
     */
    private String cellPhone;

    /**
     * 线索来源
     */
    private String state;

    /**
     * 线索状态
     */
    private String source;

    /**
     * 创建者id
     */
    private String createBy;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 修改者id
     */
    private String editBy;

    /**
     * 修改时间
     */
    private String editTime;

    /**
     * 线索描述
     */
    private String description;

    /**
     * 联系纪要
     */
    private String contactSummary;

    /**
     * 下次联系时间
     */
    private String nextContactTime;

    /**
     * 详细地址
     */
    private String address;
}