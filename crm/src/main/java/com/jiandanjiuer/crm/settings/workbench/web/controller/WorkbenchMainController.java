package com.jiandanjiuer.crm.settings.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 简单
 * @date 2020/8/6 20:58
 */
@Controller
public class WorkbenchMainController {
    @RequestMapping("/workbench/main/index.do")
    public String index(){
        return "workbench/main/index";
    }
}
