package com.simple.crm.workbench.mapper.customer;

import com.simple.crm.workbench.domain.customer.Customer;

/**
 * @author 24245
 */
public interface CustomerMapper {
    int deleteByPrimaryKey(String id);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
}