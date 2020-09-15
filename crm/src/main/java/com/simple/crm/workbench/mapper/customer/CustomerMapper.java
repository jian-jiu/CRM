package com.simple.crm.workbench.mapper.customer;

import com.simple.crm.workbench.domain.customer.Customer;

import java.util.List;
import java.util.Map;

/**
 * 客户
 *
 * @author 24245
 */
public interface CustomerMapper {
    int deleteByPrimaryKey(String id);

    int deleteByMultiplePrimaryKeys(String[] ids);


    int insert(Customer record);

    int insertSelective(Customer record);


    Customer selectByPrimaryKey(String id);

    Customer selectCustomerById(String id);

    Customer selectCustomerForDetailById(String id);

    /**
     * 根据name查询客户是否存在
     *
     * @param name 客户名字
     * @return 客户对象
     */
    Customer selectCustomerByName(String name);

    List<Customer> selectCustomerLikeName(String name);

    List<Customer> selectPagingCustomerForDetail(Map<String, Object> map);

    long selectCountCustomer(Map<String, Object> map);


    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);

}