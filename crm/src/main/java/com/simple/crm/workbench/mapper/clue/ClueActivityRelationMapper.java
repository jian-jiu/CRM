package com.simple.crm.workbench.mapper.clue;

import com.simple.crm.workbench.domain.clue.ClueActivityRelation;

import java.util.List;

/**
 * 线索市场活动关系
 *
 * @author 24245
 */
public interface ClueActivityRelationMapper {
    /**
     * 根据市场活动id查询数据
     *
     * @param activityId 市场活动id
     * @return 查询条数
     */
    ClueActivityRelation selectClueActivityRelationByActivity(String activityId);

    /**
     * 根据id查询线索市场活动关系
     *
     * @param id id
     * @return 线索市场活动关系对象
     */
    ClueActivityRelation selectByPrimaryKey(String id);

    List<ClueActivityRelation> selectByClueId(String clueId);

    List<ClueActivityRelation> selectByActivityId(String activityId);


    /**
     * 添加一条线索市场活动关系
     *
     * @param record 线索市场活动关系对象
     * @return 条件条数
     */
    int insert(ClueActivityRelation record);

    /**
     * 选择性添加一条线索市场活动关系
     *
     * @param record 线索市场活动关系对象
     * @return 条件条数
     */
    int insertSelective(ClueActivityRelation record);

    /**
     * 根据list线索关系对象添加数据
     *
     * @param clueActivityRelationList 线索关系list对象
     * @return 添加条数
     */
    int insertClueActivityRelationList(List<ClueActivityRelation> clueActivityRelationList);


    /**
     * 根据id选择性修改线索市场活动关系数据
     *
     * @param record 线索市场活动关系对象
     * @return 修改条数
     */
    int updateByPrimaryKeySelective(ClueActivityRelation record);

    /**
     * 根据id修改线索市场活动关系数据
     *
     * @param record 线索市场活动关系对象
     * @return 修改条数
     */
    int updateByPrimaryKey(ClueActivityRelation record);


    /**
     * 根据id删除数据
     *
     * @param id id
     * @return 市场条数
     */
    int deleteByPrimaryKey(String id);

    /**
     * 根据多个线索id删除线索市场活动关系
     *
     * @param clueIds 线索id数组
     * @return 删除条数
     */
    int deleteByClueId(String[] clueIds);

    /**
     * 根据多个市场活动id删除线索市场活动关系
     *
     * @param activityIds 市场活动id数组
     * @return 删除条数
     */
    int deleteByActivityId(String[] activityIds);
}