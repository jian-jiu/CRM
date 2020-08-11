package com.jiandanjiuer.crm.settings.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contants;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.settings.domain.DicType;
import com.jiandanjiuer.crm.settings.service.DicTypeService;
import com.jiandanjiuer.crm.settings.service.impl.DicTypeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 数据字典控制层
 *
 * @author 简单
 * @date 2020/8/7 20:08
 */
@Controller
public class DicTypeController {

    @Autowired
    private DicTypeService dicTypeService;

    /**
     * 跳转到数据字典工作区
     *
     * @param model
     * @return
     */
    @RequestMapping("/settings/dictionary/type/index.do")
    public String index(Model model) {
        List<DicType> dicTypesList = dicTypeService.queryAllDicTypes();
        model.addAttribute("dicTypesList", dicTypesList);
        return "settings/dictionary/type/index";
    }

    /**
     * 跳转到添加数据字典界面
     *
     * @return
     */
    @RequestMapping("/settings/dictionary/type/toSave.do")
    public String toSave() {
        return "settings/dictionary/type/save";
    }

    /**
     * 跳转到修改数据字典界面
     *
     * @return
     */
    @RequestMapping("/settings/dictionary/type/toEdit.do")
    public String toEdit() {
        return "settings/dictionary/type/edit";
    }

    /**
     * 判断数据字典编码是否存在
     *
     * @param code
     * @return
     */
    @RequestMapping("/settings/dictionary/type/checkCode.do")
    public @ResponseBody
    Object checkCode(String code) {
        DicType dicType = dicTypeService.queryDicTypeByCode(code);
        ReturnObject returnObject = new ReturnObject();
        if (dicType != null) {
            returnObject.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
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
    @RequestMapping("/settings/dictionary/type/saveCreateDicType.do")
    public @ResponseBody
    Object saveCreateDicType(DicType dicType) {
        ReturnObject returnObject = new ReturnObject();
        try {
            //添加数据
            int i = dicTypeService.saveCreateDicType(dicType);
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
     * 删除数据字典
     *
     * @param code
     * @return
     */
    @RequestMapping("/settings/dictionary/type/deleteDicTypeByCodes.do")
    public @ResponseBody
    Object deleteDicTypeByCodes(String[] code) {
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = dicTypeService.deleteDicTypeByCoeds(code);
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
}
