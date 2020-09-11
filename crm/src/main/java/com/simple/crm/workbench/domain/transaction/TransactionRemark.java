package com.simple.crm.workbench.domain.transaction;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TransactionRemark {
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
     * 交易id
     */
    private String tranId;
}