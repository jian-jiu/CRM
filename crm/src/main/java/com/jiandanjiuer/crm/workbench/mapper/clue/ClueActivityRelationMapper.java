package com.jiandanjiuer.crm.workbench.mapper.clue;

import com.jiandanjiuer.crm.workbench.domain.clue.ClueActivityRelation;

/**
 * 线索市场活动关系
 *
 * @author 24245
 */
public interface ClueActivityRelationMapper {
    /**
     * id
     *
     * @param id id
     * @return 市场条数
     */
    int deleteByPrimaryKey(String id);

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
     * 根据id查询线索市场活动关系
     *
     * @param id id
     * @return 线索市场活动关系对象
     */
    ClueActivityRelation selectByPrimaryKey(String id);

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
}