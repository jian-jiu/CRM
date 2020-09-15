package com.simple.crm.workbench.service.customer;

import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.mapper.contacts.ContactsMapper;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import com.simple.crm.workbench.mapper.customer.CustomerRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 客户实现类
 *
 * @author 简单
 * @date 2020/9/11
 */
@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final CustomerMapper customerMapper;
    private final CustomerRemarkMapper customerRemarkMapper;
    private final ContactsMapper contactsMapper;

    @Override
    public Customer findCustomerById(String id) {
        return customerMapper.selectCustomerById(id);
    }

    @Override
    public Customer findCustomerForDetailById(String id) {
        return customerMapper.selectCustomerForDetailById(id);
    }

    @Override
    public Customer findCustomerByName(String name) {
        return customerMapper.selectCustomerByName(name);
    }

    @Override
    public List<Customer> findPagingCustomerForDetail(Map<String, Object> map) {
        return customerMapper.selectPagingCustomerForDetail(map);
    }

    @Override
    public long findCountCustomer(Map<String, Object> map) {
        return customerMapper.selectCountCustomer(map);
    }


    /**
     * 添加数据
     *
     * @param customer 客户对象
     * @return 添加条数
     */
    @Override
    public int saveContacts(Customer customer) {
        return customerMapper.insertSelective(customer);
    }


    @Override
    public int updateCustomerById(Customer record) {
        return customerMapper.updateByPrimaryKeySelective(record);
    }


    /**
     * 根据多个id删除客户，删除客户备注,把联系人客户名称设置为空
     *
     * @param ids id数组
     * @return 删除条数
     */
    @Override
    public int removeByMultiplePrimaryKeys(String[] ids) {
        customerRemarkMapper.deleteByCustomerIds(ids);
        contactsMapper.updateContactsSetNameIsEmptyByCustomerId(ids);
        return customerMapper.deleteByMultiplePrimaryKeys(ids);
    }
}
