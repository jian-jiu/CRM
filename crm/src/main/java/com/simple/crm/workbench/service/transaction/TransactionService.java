package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.transaction.Transaction;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
public interface TransactionService {

    List<Transaction> findPagingForDetail(Map<String, Object> map);

    long findCount(Map<String,Object> map);


    int removeByPrimaryKeys(String[] ids);


    int insertSelective(Transaction record);


}
