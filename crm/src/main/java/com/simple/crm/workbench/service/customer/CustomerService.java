package com.simple.crm.workbench.service.customer;


import com.simple.crm.workbench.domain.customer.Customer;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
public interface CustomerService {


    Customer findCustomerById(String id);

    Customer findCustomerForDetailById(String id);

    Customer findCustomerByName(String name);

    List<Customer> findCustomerForDetail();

    List<Customer> findPagingCustomerForDetail(Map<String, Object> map);

    List<String> findAllName();

    long findCountCustomer(Map<String, Object> map);


    /**
     * 添加数据
     *
     * @param customer 客户对象
     * @return 添加条数
     */
    int saveContacts(Customer customer);


    int updateCustomerById(Customer record);


    int removeByMultiplePrimaryKeys(String[] ids);

}
