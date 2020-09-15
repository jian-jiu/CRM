package com.simple.crm.workbench.mapper.customer;

import com.simple.crm.workbench.domain.customer.CustomerRemark;

import java.util.List;

public interface CustomerRemarkMapper {
    int deleteByPrimaryKey(String id);

    int deleteByCustomerIds(String[] ids);


    int insert(CustomerRemark record);

    int insertSelective(CustomerRemark record);


    CustomerRemark selectByPrimaryKey(String id);

    CustomerRemark selectCustomerRemarkForDetailById(String id);

    List<CustomerRemark> selectAllCustomerRemarkForDetailByCustomerId(String customerId);


    int updateByPrimaryKeySelective(CustomerRemark record);

    int updateByPrimaryKey(CustomerRemark record);

}