package com.simple.crm.workbench.service.customer;

import com.simple.crm.workbench.domain.customer.CustomerRemark;
import com.simple.crm.workbench.mapper.customer.CustomerRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
@Service
@RequiredArgsConstructor
public class CustomerRemarkServiceImpl implements CustomerRemarkService {

    private final CustomerRemarkMapper customerRemarkMapper;

    @Override
    public CustomerRemark findCustomerRemarkForDetailById(String id) {
        return customerRemarkMapper.selectCustomerRemarkForDetailById(id);
    }

    @Override
    public List<CustomerRemark> findAllCustomerRemarkForDetailByCustomerId(String customerId) {
        return customerRemarkMapper.selectAllCustomerRemarkForDetailByCustomerId(customerId);
    }


    @Override
    public int saveCustomerRemark(CustomerRemark customerRemark) {
        return customerRemarkMapper.insertSelective(customerRemark);
    }


    @Override
    public int modifyCustomerRemark(CustomerRemark customerRemark) {
        return customerRemarkMapper.updateByPrimaryKeySelective(customerRemark);
    }


    @Override
    public int removeCustomerRemark(String id) {
        return customerRemarkMapper.deleteByPrimaryKey(id);
    }
}
