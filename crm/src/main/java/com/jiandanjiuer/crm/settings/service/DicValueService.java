package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.DicValue;

import java.util.List;

/**
 * 数据值业务接口
 *
 * @author 简单
 * @date 2020/8/12
 */
public interface DicValueService {

    /**
     * 查询所有数据值
     *
     * @return
     */
    List<DicValue> queryAllDicValues();

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    DicValue queryDicValueById(String id);

    /**
     * 根据数据字典类型查询数据值
     *
     * @param typeCode 数据字典类型
     * @return 数据值list集合
     */
    List<DicValue> findDicValueByDicType(String typeCode);


    /**
     * 修改数据值
     *
     * @param dicValue
     * @return
     */
    int saveEditDicValue(DicValue dicValue);

    /**
     * 添加数据值
     *
     * @param dicValue
     * @return
     */
    int saveCreateDicValue(DicValue dicValue);


    /**
     * 按照ids删除数据
     *
     * @param codes
     * @return
     */
    int deleteDicValueByIds(String[] codes);
}
