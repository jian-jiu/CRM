package com.simple.crm.workbench.service.customer;

import com.simple.crm.workbench.domain.customer.CustomerRemark;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
public interface CustomerRemarkService {
    CustomerRemark findCustomerRemarkForDetailById(String id);

    List<CustomerRemark> findAllCustomerRemarkForDetailByCustomerId(String customerd);


    int saveCustomerRemark(CustomerRemark customerRemark);


    int modifyCustomerRemark(CustomerRemark customerRemark);


    int removeCustomerRemark(String id);
}
