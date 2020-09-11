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
public class ContactsRemark implements Serializable {
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
     * 联络id
     */
    private String contactsId;
}