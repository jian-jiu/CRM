package com.simple.crm.settings.web.controller;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.DicType;
import com.simple.crm.settings.domain.DicValue;
import com.simple.crm.settings.service.dictype.DicTypeService;
import com.simple.crm.settings.service.dicvalue.DicValueService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 数据字典值控制层
 *
 * @author 简单
 * @date 2020/8/7 20:08
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/settings/dictionary/value/")
public class DicValueController {

    private final DicValueService dicValueService;
    private final DicTypeService dicTypeService;

    /**
     * 跳转到字典值工作区
     *
     * @param modelAndView ModelAndView对象
     * @return 数据以及视图
     */
    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        //查询数据字典值
        List<DicValue> dicValuesList = dicValueService.queryAllDicValues();
        modelAndView.addObject("dicValuesList", dicValuesList);
        modelAndView.setViewName("settings/dictionary/value/index");
        return modelAndView;
    }

    /**
     * 跳转到添加数据值界面
     *
     * @return 数据以及视图
     */
    @RequestMapping("toSave")
    public ModelAndView toSave(ModelAndView modelAndView) {
        //查询数据字典类型
        List<DicType> dicTypesList = dicTypeService.queryAllDicTypes();
        modelAndView.addObject("dicTypesList", dicTypesList);
        modelAndView.setViewName("settings/dictionary/value/save");
        return modelAndView;
    }

    /**
     * 根据code查询所有数据
     * 跳转到修改界面
     *
     * @param id 数据字典值id
     * @return 数据以及视图
     */
    @RequestMapping("editDicValue")
    public ModelAndView editDicValue(String id, ModelAndView modelAndView) {
        //根据id查询数据字典值
        DicValue dicValue = dicValueService.queryDicValueById(id);
        modelAndView.addObject("dicValue", dicValue);
        modelAndView.setViewName("settings/dictionary/value/edit");
        return modelAndView;
    }


    /**
     * 添加数据值
     *
     * @param dicValue 数据字典值对象
     * @return 结果集
     */
    @RequestMapping("saveCreateDicValue")
    public Object saveCreateDicValue(DicValue dicValue) {
        ReturnObject returnObject = new ReturnObject();
        dicValue.setId(UUIDUtils.getUUID());
        try {
            //添加数据
            int i = dicValueService.saveCreateDicValue(dicValue);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("数据保存失败,出现异常");
        }
        return returnObject;
    }

    /**
     * 根据多个数据字典值id删除数据字典值
     *
     * @param id 数据字典值id
     * @return 结果集
     */
    @RequestMapping("deleteDicValueByIds")
    public Object deleteDicValueByIds(String[] id) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicValueService.deleteDicValueByIds(id);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("删除数据失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除数据失败,出现异常");
        }
        return returnObject;
    }

    /**
     * 修改数据字典
     *
     * @param dicValue 数据字典值对象
     * @return 结果集
     */
    @RequestMapping("saveEditDicValue")
    public Object saveEditDicValue(DicValue dicValue) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicValueService.saveEditDicValue(dicValue);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("数据修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("数据修改失败,出现异常");
        }
        return returnObject;
    }

}
