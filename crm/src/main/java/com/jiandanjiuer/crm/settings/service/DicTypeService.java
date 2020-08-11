package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.DicType;

import java.util.List;

/**
 * @author 简单
 */
public interface DicTypeService {
    /**
     *查询所有数据字典
     * @return
     */
    List<DicType> queryAllDicTypes();

    /**
     * 按照code查询
     * @param code
     * @return
     */
    DicType queryDicTypeByCode(String code);

    /**
     * 添加数据字典
     * @param dicType
     * @return
     */
    int saveCreateDicType(DicType dicType);

    /**
     * 按照coed删除数据
     * @param codes
     * @return
     */
    int deleteDicTypeByCoeds(String[] codes);
}
