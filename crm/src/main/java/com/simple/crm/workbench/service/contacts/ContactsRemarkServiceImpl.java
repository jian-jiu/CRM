package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsRemark;
import com.simple.crm.workbench.mapper.contacts.ContactsRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
@Service
@RequiredArgsConstructor
public class ContactsRemarkServiceImpl implements ContactsRemarkService {

    private final ContactsRemarkMapper contactsRemarkMapper;

    @Override
    public ContactsRemark findContactsRemarkForDetailById(String id) {
        return contactsRemarkMapper.selectContactsRemarkForDetailById(id);
    }

    @Override
    public List<ContactsRemark> findAllContactsRemarkForDetailByContactsId(String contactsId) {
        return contactsRemarkMapper.selectAllContactsRemarkForDetailByContactsId(contactsId);
    }

    @Override
    public int saveContactsRemark(ContactsRemark contactsRemark) {
        return contactsRemarkMapper.insertSelective(contactsRemark);
    }

    @Override
    public int modifyContactsRemark(ContactsRemark contactsRemark) {
        return contactsRemarkMapper.updateByPrimaryKeySelective(contactsRemark);
    }

    @Override
    public int removeContactsRemark(String id) {
        return contactsRemarkMapper.deleteByPrimaryKey(id);
    }
}
