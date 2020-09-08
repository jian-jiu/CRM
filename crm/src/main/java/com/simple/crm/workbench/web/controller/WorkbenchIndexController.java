package com.simple.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 跳转到业务工作区
 *
 * @author 简单
 * @date 2020/8/4 16:38
 */
@Controller
@RequestMapping("/workbench/")
public class WorkbenchIndexController {
    /**
     * 跳转到业务主界面
     * @return 业务主界面
     */
    @RequestMapping("index")
    public String index() {
        return "workbench/index";
    }
}
