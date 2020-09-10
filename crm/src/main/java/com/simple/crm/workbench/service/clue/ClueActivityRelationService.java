package com.simple.crm.workbench.service.clue;

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
     * 添加线索市场活动关系
     * @param clueId 线索id
     * @param activityIds 市场活动id
     * @return 添加条数
     */
    int addClueActivityRelation(String clueId,String[] activityIds);
}
