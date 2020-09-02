package com.jiandanjiuer.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 数据字典
 *
 * @author 简单
 * @date 2020/8/7 11:35
 */
@Controller
public class DictionaryIndexController {
    /**
     * 跳转到数据字典界面
     *
     * @return
     */
    @RequestMapping("/settings/dictionary/index")
    public String index() {
        return "/settings/dictionary/index";
    }
}
