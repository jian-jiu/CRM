package com.jiandanjiuer.crm.settings.web.controller;

import com.jiandanjiuer.crm.settings.domain.DicType;
import com.jiandanjiuer.crm.settings.service.DicTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @author 简单
 * @date 2020/8/7 20:08
 */
@Controller
public class DicValueController {

    @RequestMapping("/settings/dictionary/value/index.do")
    public String index(Model model) {

        return "settings/dictionary/value/index";
    }
}
