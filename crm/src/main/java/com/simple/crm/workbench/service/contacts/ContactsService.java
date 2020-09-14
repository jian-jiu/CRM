package com.simple.crm.workbench.service.contacts;

import com.simple.crm.workbench.domain.contacts.Contacts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
public interface ContactsService {

    Contacts findByPrimaryKey(String id);

    Contacts findContactsDetailedCustomerIdById(String id);

    List<Contacts> findPagingContactsForDetail(Map<String,Object> map);

    long findCountContacts(HashMap<String, Object> map);


    int removeByMultiplePrimaryKey(String[] ids);


    int updateByPrimaryKeySelective(Contacts contacts);


    int addContacts(Contacts contacts);


}
