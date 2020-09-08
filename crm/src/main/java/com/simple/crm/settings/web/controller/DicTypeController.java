package com.simple.crm.settings.web.controller;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.settings.domain.DicType;
import com.simple.crm.settings.service.dictype.DicTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 数据字典类型控制层
 *
 * @author 简单
 * @date 2020/8/7 20:08
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/settings/dictionary/type/")
public class DicTypeController {

    private final DicTypeService dicTypeService;

    /**
     * 跳转到数据字典工作区
     *
     * @param modelAndView ModelAndView对象
     * @return 视图
     */
    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        //查询所有数据字典类型
        List<DicType> dicTypeList = dicTypeService.queryAllDicTypes();
        modelAndView.addObject("dicTypeList", dicTypeList);
        modelAndView.setViewName("settings/dictionary/type/index");
        return modelAndView;
    }

    /**
     * 跳转到添加数据字典界面
     *
     * @return
     */
    @RequestMapping("toSave")
    public ModelAndView toSave(ModelAndView modelAndView) {
        modelAndView.setViewName("settings/dictionary/type/save");
        return modelAndView;
    }

    /**
     * 根据code查询所有数据
     * 跳转到修改界面
     *
     * @param code
     * @return
     */
    @RequestMapping("editDIcType")
    public ModelAndView editDIcType(String code, ModelAndView modelAndView) {
        DicType dicType = dicTypeService.queryDicTypeByCode(code);
        modelAndView.addObject("dicType", dicType);
        modelAndView.setViewName("settings/dictionary/type/edit");
        return modelAndView;
    }


    /**
     * 查询所有数据字典类型
     *
     * @return 数据字典类型List集合
     */
    @RequestMapping("findAllDicType")
    public Object findAllDicType() {
        return dicTypeService.queryAllDicTypes();
    }

    /**
     * 判断数据字典编码是否存在
     *
     * @param code
     * @return
     */
    @RequestMapping("checkCode")
    public Object checkCode(String code) {
        ReturnObject returnObject = new ReturnObject();
        DicType dicType = dicTypeService.queryDicTypeByCode(code);
        if (dicType == null) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            returnObject.setMessage("编码已经存在");
        }
        return returnObject;
    }

    /**
     * 添加数据字典
     *
     * @param dicType
     * @return
     */
    @PostMapping("saveCreateDicType")
    public Object saveCreateDicType(DicType dicType) {
        ReturnObject returnObject = new ReturnObject();
        try {
            //添加数据
            int i = dicTypeService.saveCreateDicType(dicType);
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
     * 修改数据字典
     *
     * @param dicType
     * @return
     */
    @PostMapping("saveEditDicType")
    public Object saveEditDicType(DicType dicType) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicTypeService.saveEditDicType(dicType);
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

    /**
     * 删除数据字典
     *
     * @param code
     * @return
     */
    @PostMapping("deleteDicTypeByCodes")
    public Object deleteDicTypeByCodes(String[] code) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicTypeService.deleteDicTypeByCoeds(code);
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

}
