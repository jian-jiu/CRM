package com.jiandanjiuer.crm.settings.service;

import com.jiandanjiuer.crm.settings.domain.DicValue;
import com.jiandanjiuer.crm.settings.mapper.DicValueMapper;
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
     * 修改数据值
     *
     * @param dicValue
     * @return
     */
    @Override
    public int saveEditDicValue(DicValue dicValue) {
        return dicValueMapper.updateDicValue(dicValue);
    }

}
