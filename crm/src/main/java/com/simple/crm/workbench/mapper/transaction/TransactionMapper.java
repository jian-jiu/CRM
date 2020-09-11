package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.Transaction;

public interface TransactionMapper {
    int deleteByPrimaryKey(String id);

    int insert(Transaction record);

    int insertSelective(Transaction record);

    Transaction selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Transaction record);

    int updateByPrimaryKey(Transaction record);
}