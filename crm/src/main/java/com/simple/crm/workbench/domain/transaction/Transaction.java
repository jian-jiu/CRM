package com.simple.crm.workbench.domain.transaction;

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
public class Transaction implements Serializable {
    private String id;

    private String owner;

    private String money;

    private String name;

    private String expectedDate;

    private String customerId;

    private String stage;

    private String type;

    private String source;

    private String activityId;

    private String contactsId;

    private String createBy;

    private String createTime;

    private String editBy;

    private String editTime;

    private String description;

    private String contactSummary;

    private String nextContactTime;
}