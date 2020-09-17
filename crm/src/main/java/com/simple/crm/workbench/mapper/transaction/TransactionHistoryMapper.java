package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionHistory;

import java.util.List;

public interface TransactionHistoryMapper {
    int deleteByPrimaryKey(String id);

    int deleteByTranIds(String[] ids);


    int insert(TransactionHistory record);

    int insertSelective(TransactionHistory record);


    TransactionHistory selectByPrimaryKey(String id);

    List<TransactionHistory> selectForDetailByTranId(String tranId);


    int updateByPrimaryKeySelective(TransactionHistory record);

    int updateByPrimaryKey(TransactionHistory record);
}