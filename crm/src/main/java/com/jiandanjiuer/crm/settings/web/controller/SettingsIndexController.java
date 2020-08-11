package com.jiandanjiuer.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 数字界面
 *
 * @author 简单
 * @date 2020/8/7 11:03
 */
@Controller
public class SettingsIndexController {
    /**
     * 跳转到设置界面
     *
     * @return
     */
    @RequestMapping("/settings/index.do")
    public String index() {
        return "settings/index";
    }
}
