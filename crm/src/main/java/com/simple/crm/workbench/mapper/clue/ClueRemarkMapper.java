package com.simple.crm.workbench.mapper.clue;

import com.simple.crm.workbench.domain.clue.ClueRemark;

import java.util.List;

/**
 * 线索备注
 *
 * @author 24245
 */
public interface ClueRemarkMapper {
    /**
     * 根据id查询线索备注
     *
     * @param id id
     * @return 线索备注对象
     */
    ClueRemark selectByPrimaryKey(String id);

    List<ClueRemark> selectByClueId(String clueId);

    /**
     * 根据id查询详细的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    ClueRemark selectClueRemarkForDetailById(String id);

    /**
     * 根据线索id查询详细的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    List<ClueRemark> selectClueRemarkForDetailByClueId(String id);


    /**
     * 根据线索备注对象添加数据
     *
     * @param record 线索备注对象
     * @return 添加条数
     */
    int insert(ClueRemark record);

    /**
     * 选择性添加线索备注
     *
     * @param record 线索备注对象
     * @return 添加条数
     */
    int insertSelective(ClueRemark record);


    /**
     * 根据id选择性修改线索备注数据
     *
     * @param record 线索备注对象
     * @return 修改条数
     */
    int updateByPrimaryKeySelective(ClueRemark record);

    /**
     * 根据id修改线索备注数据
     *
     * @param record 线索备注对象
     * @return 修改条数
     */
    int updateByPrimaryKey(ClueRemark record);


    /**
     * 根据id删除数据
     *
     * @param id id
     * @return 删除条数
     */
    int deleteByPrimaryKey(String id);

    /**
     * 根据多个线索id删除线索备注
     * @param clueIds 线索id数组
     * @return 删除条数
     */
    int deleteByClueId(String[] clueIds);
}