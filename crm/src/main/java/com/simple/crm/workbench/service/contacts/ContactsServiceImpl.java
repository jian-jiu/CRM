package com.simple.crm.workbench.service.contacts;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.mapper.contacts.ContactsActivityRelationMapper;
import com.simple.crm.workbench.mapper.contacts.ContactsMapper;
import com.simple.crm.workbench.mapper.contacts.ContactsRemarkMapper;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 联系人实现类
 *
 * @author 简单
 * @date 2020/9/11
 */
@Service
@RequiredArgsConstructor
public class ContactsServiceImpl implements ContactsService {

    private final ContactsMapper contactsMapper;
    private final ContactsRemarkMapper contactsRemarkMapper;
    private final ContactsActivityRelationMapper contactsActivityRelationMapper;

    private final CustomerMapper customerMapper;

    private final HttpSession session;

    @Override
    public Contacts findByPrimaryKey(String id) {
        return contactsMapper.selectByPrimaryKey(id);
    }

    @Override
    public Contacts findContactsDetailedCustomerIdById(String id) {
        return contactsMapper.selectContactsDetailedCustomerIdById(id);
    }

    @Override
    public Contacts findContactsForDetailById(String id) {
        return contactsMapper.selectContactsForDetailById(id);
    }

    @Override
    public List<Contacts> findContactsForDetail() {
        return contactsMapper.selectContactsForDetail();
    }

    /**
     * 查询联系人客户是否存在，不存在就创建
     *
     * @param contacts 联系人对象
     * @return 联系人对象
     */
    private Contacts findContactsCustomerId(Contacts contacts) {
        if (!("".equals(contacts.getCustomerId()))) {
            Customer customer = customerMapper.selectCustomerByName(contacts.getCustomerId());
            if (customer == null) {
                User user = (User) session.getAttribute(Contents.SESSION_USER);
                //创建一个客户
                customer = new Customer();
                customer.setId(UUIDUtils.getUUID());
                customer.setOwner(user.getId());
                customer.setName(contacts.getCustomerId());
                customer.setCreateTime(DateUtils.formatDateTime(new Date()));
                customer.setCreateBy(user.getId());
                customerMapper.insertSelective(customer);
            }
            contacts.setCustomerId(customer.getId());
        }
        return contacts;
    }

    @Override
    public List<Contacts> findPagingContactsForDetail(Map<String, Object> map) {
        return contactsMapper.selectPagingContactsForDetail(map);
    }

    @Override
    public List<Contacts> findContactsForDetailByName(String name) {
        return contactsMapper.selectContactsForDetailByName(name);
    }

    @Override
    public List<Contacts> findContactsForDetailByCustomerId(String customerId) {
        return contactsMapper.selectContactsForDetailByCustomerId(customerId);
    }

    @Override
    public long findCountContacts(HashMap<String, Object> map) {
        return contactsMapper.selectCountContacts(map);
    }


    /**
     * 根据多个id删除联系人,并且删除联系人备注,删除联系人和市场活动关系数据
     *
     * @param ids id数组
     * @return 删除条数
     */
    @Override
    public int removeByMultiplePrimaryKey(String[] ids) {
        contactsRemarkMapper.deleteByContactsId(ids);
        contactsActivityRelationMapper.deleteByContactsIds(ids);
        return contactsMapper.deleteByMultiplePrimaryKey(ids);
    }


    @Override
    public int updateByPrimaryKeySelective(Contacts contacts) {
        return contactsMapper.updateByPrimaryKeySelective(findContactsCustomerId(contacts));
    }


    @Override
    public int addContacts(Contacts contacts) {
            
        return contactsMapper.insertSelective(findContactsCustomerId(contacts));
    }


}
