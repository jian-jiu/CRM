package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsActivityRelation;
import com.simple.crm.workbench.mapper.contacts.ContactsActivityRelationMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
@Service
@RequiredArgsConstructor
public class ContactsActivityRelationServiceImpl implements ContactsActivityRelationService {

    private final ContactsActivityRelationMapper contactsActivityRelationMapper;

    @Override
    public int addContactsActivityRelation(List<ContactsActivityRelation> contactsActivityRelationList) {
        return contactsActivityRelationMapper.insertContactsActivityRelationList(contactsActivityRelationList);
    }

    @Override
    public int removeByPrimaryKey(String id) {
        return contactsActivityRelationMapper.deleteByPrimaryKey(id);
    }
}
