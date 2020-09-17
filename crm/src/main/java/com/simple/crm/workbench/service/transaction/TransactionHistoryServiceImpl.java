package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionHistory;
import com.simple.crm.workbench.mapper.transaction.TransactionHistoryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/17
 */
@Service
@RequiredArgsConstructor
public class TransactionHistoryServiceImpl implements TransactionHistoryService {

    private final TransactionHistoryMapper transactionHistoryMapper;

    @Override
    public List<TransactionHistory> findForDetailByTranId(String tranId) {
        return transactionHistoryMapper.selectForDetailByTranId(tranId);
    }

    @Override
    public int insertSelective(TransactionHistory record) {
        return transactionHistoryMapper.insertSelective(record);
    }
}
