package com.simple.crm.workbench.mapper.transaction;

import com.simple.crm.workbench.domain.FunnelVO;
import com.simple.crm.workbench.domain.transaction.Transaction;

import java.util.List;
import java.util.Map;

public interface TransactionMapper {
    int deleteByPrimaryKey(String id);

    int deleteByPrimaryKeys(String[] ids);


    int insert(Transaction record);

    int insertSelective(Transaction record);


    Transaction selectByPrimaryKey(String id);

    Transaction selectForDetailByPrimaryKey(String id);

    List<Transaction> selectPagingForDetail(Map<String, Object> map);

    /**
     * 根据客户id查询交易
     *
     * @param customerId 客户id
     * @return 和客户有关的交易
     */
    List<Transaction> selectForDetailByCustomerId(String customerId);

    /**
     * 根据联系人id查询交易
     *
     * @param contactsId 联系人id
     * @return 和联系人有关的
     */
    List<Transaction> selectForDetailByContactsId(String contactsId);

    /**
     * 查询交易表中各个阶段的数据
     *
     * @return 阶段数据
     */
    List<FunnelVO> selectCountOfGroupByStage();

    long selectCount(Map<String, Object> map);


    int updateByPrimaryKeySelective(Transaction record);

    int updateByPrimaryKey(Transaction record);
}