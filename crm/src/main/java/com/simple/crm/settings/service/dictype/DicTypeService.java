package com.simple.crm.settings.service.dictype;

import com.simple.crm.settings.domain.DicType;

import javax.servlet.ServletContext;
import java.util.List;

/**
 * 数据字典业务层接口
 *
 * @author 简单
 */
public interface DicTypeService {
    /**
     * 查询所有数据字典
     *
     * @return
     */
    List<DicType> queryAllDicTypes();

    /**
     * 按照code查询数据字典
     *
     * @param code
     * @return
     */
    DicType queryDicTypeByCode(String code);

    /**
     * 设置所有数据字典类型相关的数据字典值到servletContext作用域中
     * @param servletContext servlet上下文
     */
    void setAllDicTypeAndDicValueToServletContext(ServletContext servletContext);


    /**
     * 添加数据字典
     *
     * @param dicType
     * @return
     */
    int saveCreateDicType(DicType dicType);

    /**
     * 修改数据字典
     * @param dicType
     * @return
     */
    int saveEditDicType(DicType dicType);


    /**
     * 按照codes删除数据
     *
     * @param codes
     * @return
     */
    int deleteDicTypeByCoeds(String[] codes);
}
