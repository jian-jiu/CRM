package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.Clue;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/6
 */
public interface ClueService {
    /**
     * 分页查询
     *
     * @param clue     线索对象
     * @param beginNo  第几页开始
     * @param pageSize 每页条数
     * @return 线索list集合
     */
    List<Clue> findPagingForDetailClue(Clue clue, Integer beginNo, Integer pageSize);

    /**
     * 根据条件查询线索总数量
     *
     * @param clue     线索对象
     * @return 线索数量
     */
    long findCountPagingClue(Clue clue);

    /**
     * 根据id查询线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    Clue findClueById(String id);

    /**
     * 根据线索id查询详细的线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    Clue findClueForDetailById(String id);


    /**
     * 添加线索
     *
     * @param clue 线索对象
     * @return 成功条数
     */
    int addClue(Clue clue);


    /**
     * 根据id更新线索
     *
     * @param clue 线索对象
     * @return 更新条数
     */
    int modifyClueById(Clue clue);


    /**
     * 根据多个id删除线索
     *
     * @param ids 线索id数组
     * @return 删除条数
     */
    int removeClueByIds(String[] ids);
}
