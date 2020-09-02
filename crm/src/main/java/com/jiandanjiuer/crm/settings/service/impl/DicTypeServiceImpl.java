package com.jiandanjiuer.crm.settings.service.impl;

import com.jiandanjiuer.crm.settings.domain.DicType;
import com.jiandanjiuer.crm.settings.mapper.DicTypeMapper;
import com.jiandanjiuer.crm.settings.mapper.DicValueMapper;
import com.jiandanjiuer.crm.settings.service.DicTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 数据字典业务层实现类
 *
 * @author 简单
 * @date 2020/8/7 20:04
 */
@Service
public class DicTypeServiceImpl implements DicTypeService {

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Autowired
    private DicValueMapper dicValueMapper;

    /**
     * 查询所有数据字典
     *
     * @return
     */
    @Override
    public List<DicType> queryAllDicTypes() {
        return dicTypeMapper.selectAllDicTypes();
    }

    /**
     * 按照code查询数据字典
     *
     * @param code
     * @return
     */
    @Override
    public DicType queryDicTypeByCode(String code) {
        return dicTypeMapper.selectDicTypeByCode(code);
    }

    /**
     * 添加数据字典
     *
     * @param dicType
     * @return
     */
    @Override
    public int saveCreateDicType(DicType dicType) {
        return dicTypeMapper.insertDicType(dicType);
    }

    /**
     * 按照codes删除数据
     *
     * @param codes
     * @return
     */
    @Override
    public int deleteDicTypeByCoeds(String[] codes) {
        //先删除这些类型下的数据值
        dicValueMapper.deleteDicValueByTypeCodes(codes);

        return dicTypeMapper.deleteDicTypeByCodes(codes);
    }

    /**
     * 修改数据字典
     *
     * @param dicType
     * @return
     */
    @Override
    public int saveEditDicType(DicType dicType) {
        return dicTypeMapper.updateDicType(dicType);
    }
}
