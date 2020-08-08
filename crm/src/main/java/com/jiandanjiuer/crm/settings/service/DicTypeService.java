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
}
