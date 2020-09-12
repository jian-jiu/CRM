package com.simple.crm.workbench.service.customer;

import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {

    private final CustomerMapper customerMapper;


    @Override
    public List<Customer> findPagingCustomerForDetail(Map<String, Object> map) {
        return customerMapper.selectPagingCustomerForDetail(map);
    }

    @Override
    public Customer findCustomerById(String id) {
        return customerMapper.selectCustomerById(id);
    }

    @Override
    public Customer findCustomerForDetailById(String id) {
        return customerMapper.selectCustomerForDetailById(id);
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


    @Override
    public int removeByMultiplePrimaryKeys(String[] ids) {
        return customerMapper.deleteByMultiplePrimaryKeys(ids);
    }
}
