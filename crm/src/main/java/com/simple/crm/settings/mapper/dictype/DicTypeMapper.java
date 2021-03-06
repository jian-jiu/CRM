package com.simple.crm.settings.mapper.dictype;

import com.simple.crm.settings.domain.DicType;

import java.util.List;

/**
 * 数据字典mapper层
 *
 * @author 24245
 */
public interface DicTypeMapper {

    int deleteByPrimaryKey(String code);

    int insert(DicType record);

    int insertSelective(DicType record);

    DicType selectByPrimaryKey(String code);

    int updateByPrimaryKeySelective(DicType record);

    int updateByPrimaryKey(DicType record);

    /**
     * 查询所有的数据字典数据
     *
     * @return
     */
    List<DicType> selectAllDicTypes();

    /**
     * 按照code查询
     *
     * @param code
     * @return
     */
    DicType selectDicTypeByCode(String code);

    /**
     * 保存创建的数据字典
     *
     * @param dicType
     * @return
     */
    int insertDicType(DicType dicType);

    /**
     * 根据codes删除数据
     *
     * @param code
     * @return
     */
    int deleteDicTypeByCodes(String[] code);

    /**
     * 修改数据字典
     *
     * @param dicType
     * @return
     */
    int updateDicType(DicType dicType);
}