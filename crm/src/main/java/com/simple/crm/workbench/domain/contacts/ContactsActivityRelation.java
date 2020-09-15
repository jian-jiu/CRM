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
public class ContactsActivityRelation implements Serializable {
    private String id;
    /**
     * 联络id
     */
    private String contactsId;
    /**
     * 市场活动id
     */
    private String activityId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getContactsId() {
        return contactsId;
    }

    public void setContactsId(String contactsId) {
        this.contactsId = contactsId == null ? null : contactsId.trim();
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId == null ? null : activityId.trim();
    }
}