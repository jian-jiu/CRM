package com.jiandanjiuer.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 获取所有请求
 *
 * @author 简单
 * @date 2020/7/31 19:48
 */
@Controller
public class IndexController {
    /**
     * 请求跳转到主界面
     *
     * @return
     */
    @RequestMapping("/")
    public String index() {
        return "index";
    }
}
