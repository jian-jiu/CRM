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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source == null ? null : source.trim();
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId == null ? null : customerId.trim();
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName == null ? null : fullName.trim();
    }

    public String getAppellation() {
        return appellation;
    }

    public void setAppellation(String appellation) {
        this.appellation = appellation == null ? null : appellation.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getCellPhone() {
        return cellPhone;
    }

    public void setCellPhone(String cellPhone) {
        this.cellPhone = cellPhone == null ? null : cellPhone.trim();
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job == null ? null : job.trim();
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth == null ? null : birth.trim();
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy == null ? null : editBy.trim();
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime == null ? null : editTime.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getContactSummary() {
        return contactSummary;
    }

    public void setContactSummary(String contactSummary) {
        this.contactSummary = contactSummary == null ? null : contactSummary.trim();
    }

    public String getNextContactTime() {
        return nextContactTime;
    }

    public void setNextContactTime(String nextContactTime) {
        this.nextContactTime = nextContactTime == null ? null : nextContactTime.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }
}