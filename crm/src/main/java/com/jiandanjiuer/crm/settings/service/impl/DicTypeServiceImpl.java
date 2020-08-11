package com.jiandanjiuer.crm.settings.service.impl;

import com.jiandanjiuer.crm.settings.domain.DicType;
import com.jiandanjiuer.crm.settings.mapper.DicTypeMapper;
import com.jiandanjiuer.crm.settings.service.DicTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/8/7 20:04
 */
@Service("dicTypeService")
public class DicTypeServiceImpl implements DicTypeService {

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Override
    public List<DicType> queryAllDicTypes() {
        return dicTypeMapper.selectAllDicTypes();
    }

    @Override
    public DicType queryDicTypeByCode(String code) {
        return dicTypeMapper.selectDicTypeByCode(code);
    }

    @Override
    public int saveCreateDicType(DicType dicType) {
        return dicTypeMapper.insertDicType(dicType);
    }

    @Override
    public int deleteDicTypeByCoeds(String[] codes) {
        return dicTypeMapper.deleteDicTypeByCodes(codes);
    }
}
