package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionHistory;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/17
 */
public interface TransactionHistoryService {

    List<TransactionHistory> findForDetailByTranId(String tranId);

    int insertSelective(TransactionHistory record);
}
