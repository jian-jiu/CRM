package com.simple.crm.workbench.service.transaction;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.FunnelVO;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.domain.transaction.Transaction;
import com.simple.crm.workbench.domain.transaction.TransactionHistory;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import com.simple.crm.workbench.mapper.transaction.TransactionHistoryMapper;
import com.simple.crm.workbench.mapper.transaction.TransactionMapper;
import com.simple.crm.workbench.mapper.transaction.TransactionRemarkMapper;
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
    private final TransactionRemarkMapper transactionRemarkMapper;
    private final TransactionHistoryMapper transactionHistoryMapper;

    private final CustomerMapper customerMapper;

    private final HttpSession session;

    @Override
    public Transaction findForDetailByPrimaryKey(String id) {
        return transactionMapper.selectForDetailByPrimaryKey(id);
    }

    @Override
    public List<Transaction> findPagingForDetail(Map<String, Object> map) {
        return transactionMapper.selectPagingForDetail(map);
    }

    /**
     * 根据客户id查询交易
     *
     * @param customerId 客户id
     * @return 和客户有关的交易
     */
    @Override
    public List<Transaction> findForDetailByCustomerId(String customerId) {
        return transactionMapper.selectForDetailByCustomerId(customerId);
    }

    /**
     * 根据联系人id查询交易
     *
     * @param contactsId 联系人id
     * @return 和联系人有关的
     */
    @Override
    public List<Transaction> findForDetailByContactsId(String contactsId) {
        return transactionMapper.selectForDetailByContactsId(contactsId);
    }

    /**
     * 查询交易表中各个阶段的数据
     *
     * @return 阶段数据
     */
    @Override
    public List<FunnelVO> findCountOfGroupByStage() {
        return transactionMapper.selectCountOfGroupByStage();
    }

    @Override
    public long findCount(Map<String, Object> map) {
        return transactionMapper.selectCount(map);
    }

    @Override
    public int updateByPrimaryKey(Transaction transaction) {
        //添加交易历史
        addTransactionHistory(transaction);

        return transactionMapper.updateByPrimaryKeySelective(transaction);
    }


    @Override
    public int insertSelective(Transaction record) {
        if (!("".equals(record.getCustomerId().trim()))) {
            Customer customer = customerMapper.selectCustomerByName(record.getCustomerId().trim());
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
        //添加交易历史
        addTransactionHistory(record);

        return transactionMapper.insertSelective(record);
    }


    /**
     * 根据id删除交易信息,交易历史信息,交易备注信息
     *
     * @param ids id数组
     * @return 删除条数
     */
    @Override
    public int removeByPrimaryKeys(String[] ids) {
        transactionHistoryMapper.deleteByTranIds(ids);
        transactionRemarkMapper.deleteByPrimaryKeys(ids);
        return transactionMapper.deleteByPrimaryKeys(ids);
    }

    /**
     * 添加交易历史
     *
     * @param transaction
     * @return
     */
    public void addTransactionHistory(Transaction transaction) {
        System.out.println("++++++++++++++++++++++++++++++++");
        TransactionHistory transactionHistory = new TransactionHistory();
        transactionHistory.setId(UUIDUtils.getUUID());
        transactionHistory.setStage(transaction.getStage());
        transactionHistory.setMoney(transaction.getMoney());
        transactionHistory.setExpectedDate(transaction.getExpectedDate());
        transactionHistory.setCreateTime(DateUtils.formatDateTime(new Date()));
        transactionHistory.setCreateBy(transaction.getCreateBy());
        transactionHistory.setTranId(transaction.getId());
        transactionHistoryMapper.insertSelective(transactionHistory);
    }
}
