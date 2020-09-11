package com.simple.crm.settings.service.dicvalue;

import com.simple.crm.settings.domain.DicValue;
import com.simple.crm.settings.mapper.dicvalue.DicValueMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/8/12
 */
@Service
@RequiredArgsConstructor
public class DicValueServiceImpl implements DicValueService {

    private final DicValueMapper dicValueMapper;

    /**
     * 查询数据值
     *
     * @return
     */
    @Override
    public List<DicValue> queryAllDicValues() {
        return dicValueMapper.selectAllDicValues();
    }

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    @Override
    public DicValue queryDicValueById(String id) {
        return dicValueMapper.selectDicValueById(id);
    }

    /**
     * 根据数据字典类型查询数据值
     *
     * @param typeCode 数据字典类型
     * @return 数据值list集合
     */
    @Override
    public List<DicValue> findDicValueByDicType(String typeCode) {
        return dicValueMapper.selectDicValueByDicType(typeCode);
    }


    /**
     * 修改数据值
     *
     * @param dicValue
     * @return
     */
    @Override
    public int saveEditDicValue(DicValue dicValue) {
        return dicValueMapper.updateDicValue(dicValue);
    }

    /**
     * 添加数据值
     *
     * @param dicValue
     * @return
     */
    @Override
    public int saveCreateDicValue(DicValue dicValue) {
        return dicValueMapper.insertDicValue(dicValue);
    }


    /**
     * 根据ids删除数据
     *
     * @param codes
     * @return
     */
    @Override
    public int deleteDicValueByIds(String[] codes) {
        return dicValueMapper.deleteDicValueByIds(codes);
    }


}
