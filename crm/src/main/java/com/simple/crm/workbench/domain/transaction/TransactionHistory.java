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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage == null ? null : stage.trim();
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money == null ? null : money.trim();
    }

    public String getExpectedDate() {
        return expectedDate;
    }

    public void setExpectedDate(String expectedDate) {
        this.expectedDate = expectedDate == null ? null : expectedDate.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId == null ? null : tranId.trim();
    }
}