package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsRemark;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
public interface ContactsRemarkService {
    ContactsRemark findContactsRemarkForDetailById(String id);

    List<ContactsRemark> findAllContactsRemarkForDetailByContactsId(String contactsd);


    int saveContactsRemark(ContactsRemark contactsRemark);

    int modifyContactsRemark(ContactsRemark contactsRemark);

    int removeContactsRemark(String id);
}
