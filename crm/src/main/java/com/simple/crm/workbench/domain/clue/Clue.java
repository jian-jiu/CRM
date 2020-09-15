package com.simple.crm.workbench.domain.clue;

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


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
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

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company == null ? null : company.trim();
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job == null ? null : job.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website == null ? null : website.trim();
    }

    public String getCellPhone() {
        return cellPhone;
    }

    public void setCellPhone(String cellPhone) {
        this.cellPhone = cellPhone == null ? null : cellPhone.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source == null ? null : source.trim();
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