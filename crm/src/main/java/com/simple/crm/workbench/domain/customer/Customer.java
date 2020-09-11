package com.simple.crm.workbench.domain.customer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Customer {
    private String id;

    private String owner;

    private String name;
    /**
     * 网站
     */
    private String website;

    private String phone;

    private String createBy;

    private String createTime;

    private String editBy;

    private String editTime;
    /**
     * 联系人摘要
     */
    private String contactSummary;

    private String nextContactTime;
    /**
     * 描述
     */
    private String description;

    private String address;
}