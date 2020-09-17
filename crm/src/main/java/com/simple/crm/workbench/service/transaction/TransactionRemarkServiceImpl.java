package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionRemark;
import com.simple.crm.workbench.mapper.transaction.TransactionRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/17
 */
@Service
@RequiredArgsConstructor
public class TransactionRemarkServiceImpl implements TransactionRemarkService {

    private final TransactionRemarkMapper transactionRemarkMapper;

    @Override
    public TransactionRemark findTransactionRemarkForDetailById(String id) {
        return transactionRemarkMapper.selectForDetailById(id);
    }

    @Override
    public List<TransactionRemark> findForDetailByTranId(String tranId) {
        return transactionRemarkMapper.selectForDetailByTranId(tranId);
    }


    @Override
    public int addTransactionRemark(TransactionRemark transactionRemark) {
        return transactionRemarkMapper.insertSelective(transactionRemark);
    }


    @Override
    public int modifyTransactionRemark(TransactionRemark transactionRemark) {
        return transactionRemarkMapper.updateByPrimaryKeySelective(transactionRemark);
    }


    @Override
    public int removeTransactionRemarkById(String id) {
        return transactionRemarkMapper.deleteByPrimaryKey(id);
    }


}
