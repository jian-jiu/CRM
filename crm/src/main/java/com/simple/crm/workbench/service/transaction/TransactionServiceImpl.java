package com.simple.crm.workbench.service.transaction;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.domain.transaction.Transaction;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import com.simple.crm.workbench.mapper.transaction.TransactionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService {

    private final TransactionMapper transactionMapper;

    private final CustomerMapper customerMapper;

    private final HttpSession session;

    @Override
    public List<Transaction> findPagingForDetail(Map<String, Object> map) {
        return transactionMapper.selectPagingForDetail(map);
    }

    @Override
    public long findCount(Map<String, Object> map) {
        return transactionMapper.selectCount(map);
    }


    @Override
    public int removeByPrimaryKeys(String[] ids) {
        return transactionMapper.deleteByPrimaryKeys(ids);
    }


    @Override
    public int insertSelective(Transaction record) {
        if (!("".equals(record.getCustomerId()))) {
            Customer customer = customerMapper.selectCustomerByName(record.getCustomerId());
            if (customer == null) {
                User user = (User) session.getAttribute(Contents.SESSION_USER);
                //创建一个客户
                customer = new Customer();
                customer.setId(UUIDUtils.getUUID());
                customer.setOwner(user.getId());
                customer.setName(record.getCustomerId());
                customer.setCreateTime(DateUtils.formatDateTime(new Date()));
                customer.setCreateBy(user.getId());
                customerMapper.insertSelective(customer);
            }
            record.setCustomerId(customer.getId());
        }
        return transactionMapper.insertSelective(record);
    }
}
