package com.simple.crm.settings.mapper.dicvalue;

import com.simple.crm.settings.domain.DicValue;

import java.util.List;

/**
 * 字典值接口mapper层
 *
 * @author 24245
 */
public interface DicValueMapper {

    int deleteByPrimaryKey(String id);

    int insert(DicValue record);

    int insertSelective(DicValue record);

    DicValue selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DicValue record);

    int updateByPrimaryKey(DicValue record);


    /**
     * 查询所有数据值
     *
     * @return
     */
    List<DicValue> selectAllDicValues();

    /**
     * 根据id查找数据
     *
     * @param id
     * @return
     */
    DicValue selectDicValueById(String id);

    /**
     * 根据数据字典类型查询数据值
     *
     * @param typeCode 数据字典类型
     * @return 数据值list集合
     */
    List<DicValue> selectDicValueByDicType(String typeCode);


    /**
     * 保存创建的数据值
     *
     * @param dicValue
     * @return
     */
    int insertDicValue(DicValue dicValue);


    /**
     * 修改数据值
     *
     * @param dicValue
     * @return
     */
    int updateDicValue(DicValue dicValue);


    /**
     * 根据ids删除数据
     *
     * @param ids
     * @return
     */
    int deleteDicValueByIds(String[] ids);

    /**
     * 根据TypeCodes删除这些类型下的所有数据字典值
     *
     * @param typeCodes
     * @return
     */
    int deleteDicValueByTypeCodes(String[] typeCodes);
}