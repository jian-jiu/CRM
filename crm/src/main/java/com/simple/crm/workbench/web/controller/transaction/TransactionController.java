package com.simple.crm.workbench.web.controller.transaction;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author 简单
 * @date 2020/9/11
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("workbench/transaction")
public class TransactionController {

    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView){
        modelAndView.setViewName("workbench/transaction/index");
        return modelAndView;
    }
}
