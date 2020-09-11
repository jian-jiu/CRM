package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionRemark;

public interface TransactionRemarkMapper {
    int deleteByPrimaryKey(String id);

    int insert(TransactionRemark record);

    int insertSelective(TransactionRemark record);

    TransactionRemark selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TransactionRemark record);

    int updateByPrimaryKey(TransactionRemark record);
}