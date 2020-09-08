package com.simple.crm.workbench.mapper.clue;

import com.simple.crm.workbench.domain.clue.Clue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 线索mapper接口
 *
 * @author 24245
 */
public interface ClueMapper {
    /**
     * 根据id删除线索
     *
     * @param id 线索id
     * @return 删除条数
     */
    int deleteByPrimaryKey(String id);

    /**
     * 添加线索
     *
     * @param record 线索对象
     * @return 添加条数
     */
    int insert(Clue record);

    /**
     * 选择性添加线索
     *
     * @param record 线索对象
     * @return 添加条数
     */
    int insertSelective(Clue record);

    /**
     * 根据线索id查询线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    Clue selectByPrimaryKey(String id);

    /**
     * 选择性更新线索
     *
     * @param record 线索对象
     * @return 更新条数
     */
    int updateByPrimaryKeySelective(Clue record);

    /**
     * 根据线索id更新线索
     *
     * @param record 线索对象
     * @return 更新条数
     */
    int updateByPrimaryKey(Clue record);

    /**
     * 分页查询信息的线索list集合
     *
     * @param clue     线索对象
     * @param beginNo  第几页开始
     * @param pageSize 每页条数
     * @return 线索list集合
     */
    List<Clue> selectPagingForDetailClue(@Param("clue") Clue clue,
                                         @Param("beginNo") Integer beginNo,
                                         @Param("pageSize") Integer pageSize);

    /**
     * 根据条件查询线索总数量
     *
     * @param clue 线索对象
     * @return 线索数量
     */
    long selectCountPagingClue(@Param("clue") Clue clue);

    /**
     * 根据线索id查询信息的线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    Clue selectClueForDetailById(String id);

    /**
     * 根据多个id删除线索
     *
     * @param ids 线索id数组
     * @return 删除条数
     */
    int deleteClueByIds(String[] ids);
}