package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionRemark;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/17
 */
public interface TransactionRemarkService {

    TransactionRemark findTransactionRemarkForDetailById(String id);

    List<TransactionRemark> findForDetailByTranId(String tranId);


    int addTransactionRemark(TransactionRemark transactionRemark);


    int modifyTransactionRemark(TransactionRemark transactionRemark);


    int removeTransactionRemarkById(String id);
}
