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
public class CustomerRemark {
    private String id;
    /**
     * 注释内容
     */
    private String noteContent;

    private String createBy;

    private String createTime;

    private String editBy;

    private String editTime;

    private String editFlag;
    /**
     * 顾客id
     */
    private String customerId;
}