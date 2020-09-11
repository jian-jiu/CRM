package com.simple.crm.settings.service.dictype;

import com.simple.crm.settings.domain.DicType;
import com.simple.crm.settings.domain.DicValue;
import com.simple.crm.settings.mapper.dictype.DicTypeMapper;
import com.simple.crm.settings.mapper.dicvalue.DicValueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.util.List;

/**
 * 数据字典业务层实现类
 *
 * @author 简单
 * @date 2020/8/7 20:04
 */
@Service
//@RequiredArgsConstructor
public class DicTypeServiceImpl implements DicTypeService {

    @Autowired
    private  DicTypeMapper dicTypeMapper;
    @Autowired
    private  DicValueMapper dicValueMapper;

    public DicTypeServiceImpl() {

    }

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
     * 设置所有数据字典类型相关的数据字典值到servletContext作用域中
     * @param servletContext servlet上下文
     */
    @Override
    public void setAllDicTypeAndDicValueToServletContext(ServletContext servletContext) {
        List<DicType> dicTypes = dicTypeMapper.selectAllDicTypes();
        for (DicType dicType : dicTypes) {
            List<DicValue> dicValues = dicValueMapper.selectDicValueByDicType(dicType.getCode());
            servletContext.setAttribute(dicType.getCode() + "List", dicValues);
        }
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
     * 按照codes删除数据以及数据值
     *
     * @param codes 数据字典类型id
     * @return 删除数据条数
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
