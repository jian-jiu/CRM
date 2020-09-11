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
public class TransactionHistory {
    private String id;
    /**
     * 阶段
     */
    private String stage;
    /**
     * 钱
     */
    private String money;
    /**
     * 预期日期
     */
    private String expectedDate;

    private String createTime;

    private String createBy;
    /**
     * 交易id
     */
    private String tranId;
}