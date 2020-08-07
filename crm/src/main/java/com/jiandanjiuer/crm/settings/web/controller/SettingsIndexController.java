package com.jiandanjiuer.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 简单
 * @date 2020/8/7 11:03
 */
@Controller
public class SettingsIndexController {
    @RequestMapping("/settings/index.do")
    public String index(){
        return "settings/index";
    }
}
