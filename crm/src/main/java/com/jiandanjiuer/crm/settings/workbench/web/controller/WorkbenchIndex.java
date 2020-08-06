package com.jiandanjiuer.crm.settings.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author: 简单
 * @date: 2020/8/4 16:38
 */
@Controller
public class WorkbenchIndex {
    @RequestMapping("/workbench/index.do")
    public String index() {
        return "workbench/index";
    }
}
