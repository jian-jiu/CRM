package com.simple.crm.workbench.mapper.customer;

import com.simple.crm.workbench.domain.customer.Customer;

import java.util.List;
import java.util.Map;

/**
 * @author 24245
 */
public interface CustomerMapper {
    int deleteByPrimaryKey(String id);

    int deleteByMultiplePrimaryKeys(String[] ids);


    int insert(Customer record);

    int insertSelective(Customer record);


    Customer selectByPrimaryKey(String id);

    List<Customer> selectPagingCustomerForDetail(Map<String, Object> map);

    Customer selectCustomerById(String id);

    Customer selectCustomerForDetailById(String id);

    long selectCountCustomer(Map<String, Object> map);


    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
}