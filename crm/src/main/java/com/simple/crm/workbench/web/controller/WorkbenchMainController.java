package com.simple.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 业务工作区展示
 *
 * @author 简单
 * @date 2020/8/6 20:58
 */
@Controller
public class WorkbenchMainController {
    /**
     * 跳转到业务工作区
     * @return
     */
    @RequestMapping("/workbench/main/index")
    public String index() {
        return "workbench/main/index";
    }
}
