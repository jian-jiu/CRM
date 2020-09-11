package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionHistory;

public interface TransactionHistoryMapper {
    int deleteByPrimaryKey(String id);

    int insert(TransactionHistory record);

    int insertSelective(TransactionHistory record);

    TransactionHistory selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TransactionHistory record);

    int updateByPrimaryKey(TransactionHistory record);
}