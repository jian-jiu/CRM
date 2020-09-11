package com.simple.crm.workbench.domain.contacts;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Contacts implements Serializable {
    private String id;
    /**
     * 所有者
     */
    private String owner;
    /**
     * 来源
     */
    private String source;
    /**
     * 顾客id
     */
    private String customerId;
    /**
     * 名字
     */
    private String fullName;
    /**
     * 称呼
     */
    private String appellation;

    private String email;
    /**
     * 手机号
     */
    private String cellPhone;
    /**
     * 职位
     */
    private String job;
    /**
     * 出生时间
     */
    private String birth;

    private String createBy;

    private String createTime;

    private String editBy;

    private String editTime;
    /**
     * 描述
     */
    private String description;
    /**
     * 联系人摘要
     */
    private String contactSummary;

    private String nextContactTime;
    /**
     * 地址
     */
    private String address;
}