package com.jiandanjiuer.crm.settings.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contants;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.DicType;
import com.jiandanjiuer.crm.settings.domain.DicValue;
import com.jiandanjiuer.crm.settings.service.DicTypeService;
import com.jiandanjiuer.crm.settings.service.DicValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.UUID;

/**
 * @author 简单
 * @date 2020/8/7 20:08
 */
@Controller
public class DicValueController {

    @Autowired
    public DicValueService dicValueService;

    @Autowired
    private DicTypeService dicTypeService;

    /**
     * 跳转到字典值工作区
     *
     * @param model
     * @return
     */
    @RequestMapping("/settings/dictionary/value/index.do")
    public String index(Model model) {
        List<DicValue> dicValuesList = dicValueService.queryAllDicValues();
        model.addAttribute("dicValuesList", dicValuesList);
        return "settings/dictionary/value/index";
    }

    /**
     * 跳转到添加数据值界面
     *
     * @return
     */
    @RequestMapping("/settings/dictionary/value/toSave.do")
    public String toSave(Model model) {
        List<DicType> dicTypesList = dicTypeService.queryAllDicTypes();
        model.addAttribute("dicTypesList", dicTypesList);
        return "settings/dictionary/value/save";
    }

    /**
     * 添加数据值
     *
     * @param dicValue
     * @return
     */
    @RequestMapping("/settings/dictionary/value/saveCreateDicValue.do")
    public @ResponseBody
    Object saveCreateDicValue(DicValue dicValue) {
        ReturnObject returnObject = new ReturnObject();
        dicValue.setId(UUIDUtils.getUUID());
        try {
            //添加数据
            int i = dicValueService.saveCreateDicValue(dicValue);
            if (i > 0) {
                //保存成功
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                //保存失败
                returnObject.setMessage("数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            //保存失败
            returnObject.setMessage("数据保存失败，出现异常");
        }
        return returnObject;
    }

    /**
     * 删除数据值
     *
     * @param id
     * @return
     */
    @RequestMapping("/settings/dictionary/value/deleteDicValueByIds.do")
    public @ResponseBody
    Object deleteDicValueByIds(String[] id) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicValueService.deleteDicValueByIds(id);
            if (i > 0) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setMessage("删除数据失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setMessage("删除数据失败，出现异常");
        }
        return returnObject;
    }

    /**
     * 根据code查询所有数据
     * 跳转到修改界面
     *
     * @param id
     * @return
     */
    @RequestMapping("/settings/dictionary/value/editDIcValue.do")
    public String editDIcValue(String id, Model model) {
        DicValue dicValue = dicValueService.queryDicValueById(id);
        model.addAttribute("dicValue", dicValue);
        return "settings/dictionary/value/edit";
    }

    /**
     * 修改数据字典
     *
     * @param dicValue
     * @return
     */
    @RequestMapping("/settings/dictionary/value/saveEditDicValue.do")
    public @ResponseBody
    Object saveEditDicValue(DicValue dicValue) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicValueService.saveEditDicValue(dicValue);
            if (i > 0) {
                returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setMessage("数据修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setMessage("数据修改失败，出现异常");
        }
        return returnObject;
    }

}
