package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.ClueRemark;

import java.util.List;

/**
 * 线索备注
 *
 * @author 简单
 * @date 2020/9/8
 */
public interface ClueRemarkService {
    /**
     * 根据id查询信息的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    ClueRemark findClueRemarkForDetailById(String id);

    /**
     * 根据线索id查询详细的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    List<ClueRemark> findClueRemarkForDetailByClueId(String id);


    /**
     * 条件一条线索备注
     *
     * @param clueRemark 线索备注对象
     * @return 添加条数
     */
    int addClueRemark(ClueRemark clueRemark);


    /**
     * 选择性修改线索备注
     *
     * @param clueRemark 线索备注对象
     * @return 修改条数
     */
    int modifyClueRemark(ClueRemark clueRemark);


    /**
     * 根据id删除线索备注
     *
     * @param id id
     * @return 删除条数
     */
    int removeClueRemarkById(String id);
}
