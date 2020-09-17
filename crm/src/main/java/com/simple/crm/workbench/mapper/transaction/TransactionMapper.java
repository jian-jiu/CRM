package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.Transaction;

import java.util.List;
import java.util.Map;

public interface TransactionMapper {
    int deleteByPrimaryKey(String id);

    int deleteByPrimaryKeys(String[] ids);


    int insert(Transaction record);

    int insertSelective(Transaction record);


    Transaction selectByPrimaryKey(String id);

    List<Transaction> selectPagingForDetail(Map<String, Object> map);

    long selectCount(Map<String,Object> map);


    int updateByPrimaryKeySelective(Transaction record);

    int updateByPrimaryKey(Transaction record);
}