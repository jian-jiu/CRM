package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.ClueActivityRelation;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/9
 */
public interface ClueActivityRelationService {

    /**
     * 根据id删除数据
     *
     * @param id id
     * @return 市场条数
     */
    int removeByPrimaryKey(String id);

    /**
     * 根据list线索关系对象添加数据
     *
     * @param clueActivityRelationList 线索关系list对象
     * @return 添加条数
     */
    int addClueActivityRelation(List<ClueActivityRelation> clueActivityRelationList);
}
