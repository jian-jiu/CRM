package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.transaction.TransactionRemark;

import java.util.List;

public interface TransactionRemarkMapper {
    int deleteByPrimaryKey(String id);

    int deleteByPrimaryKeys(String[] ids);


    int insert(TransactionRemark record);

    int insertSelective(TransactionRemark record);


    TransactionRemark selectForDetailById(String id);

    TransactionRemark selectByPrimaryKey(String id);

    List<TransactionRemark> selectForDetailByTranId(String tranId);


    int updateByPrimaryKeySelective(TransactionRemark record);

    int updateByPrimaryKey(TransactionRemark record);
}