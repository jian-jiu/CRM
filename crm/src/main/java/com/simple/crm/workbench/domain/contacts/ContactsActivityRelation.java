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
}