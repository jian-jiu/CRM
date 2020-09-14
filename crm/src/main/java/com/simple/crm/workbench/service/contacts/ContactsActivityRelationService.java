package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsActivityRelation;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
public interface ContactsActivityRelationService {
    int addContactsActivityRelation(List<ContactsActivityRelation> contactsActivityRelationList);
}
