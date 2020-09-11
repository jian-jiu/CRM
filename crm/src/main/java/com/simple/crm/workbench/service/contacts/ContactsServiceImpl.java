package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.mapper.contacts.ContactsMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author 简单
 * @date 2020/9/11
 */
@Service
@RequiredArgsConstructor
public class ContactsServiceImpl implements ContactsService {

    private final ContactsMapper contactsMapper;
}
