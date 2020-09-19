package com.simple.crm.workbench.service.transaction;

import com.simple.crm.workbench.domain.FunnelVO;
import com.simple.crm.workbench.domain.transaction.Transaction;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/11
 */
public interface TransactionService {

    Transaction findForDetailByPrimaryKey(String id);

    List<Transaction> findPagingForDetail(Map<String, Object> map);

    /**
     * 根据客户id查询交易
     *
     * @param customerId 客户id
     * @return 和客户有关的交易
     */
    List<Transaction> findForDetailByCustomerId(String customerId);

    /**
     * 根据联系人id查询交易
     *
     * @param contactsId 联系人id
     * @return 和联系人有关的
     */
    List<Transaction> findForDetailByContactsId(String contactsId);

    /**
     * 查询交易表中各个阶段的数据
     *
     * @return 阶段数据
     */
    List<FunnelVO> findCountOfGroupByStage();

    long findCount(Map<String,Object> map);

    int updateByPrimaryKey(Transaction transaction);

    int insertSelective(Transaction record);

    int removeByPrimaryKeys(String[] ids);


}
