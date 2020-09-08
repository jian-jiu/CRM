package com.jiandanjiuer.crm.workbench.mapper;

import com.jiandanjiuer.crm.workbench.domain.Clue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 线索mapper接口
 *
 * @author 24245
 */
public interface ClueMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    int insert(Clue record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    int insertSelective(Clue record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    Clue selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    int updateByPrimaryKeySelective(Clue record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_clue
     *
     * @mbggenerated Sun Sep 06 17:11:01 CST 2020
     */
    int updateByPrimaryKey(Clue record);

    /**
     * 分页查询
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
     * 查询线索总数量
     *
     * @param clue     线索对象
     * @param beginNo  第几页开始
     * @param pageSize 每页条数
     * @return 线索数量
     */
    long selectCountPagingForDetailClue(@Param("clue") Clue clue,
                                        @Param("beginNo") Integer beginNo,
                                        @Param("pageSize") Integer pageSize);

    /**
     * 根据id查询线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    Clue selectClueById(String id);


    /**
     * 根据多个id删除线索
     *
     * @param ids 线索id数组
     * @return 删除条数
     */
    int deleteClueByIds(String[] ids);
}