package com.simple.crm.workbench.web.controller.chart;

import com.simple.crm.workbench.service.transaction.TransactionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * 统计视图
 *
 * @author 简单
 * @date 2020/9/18
 */
@RestController
@RequestMapping("/chart/")
@RequiredArgsConstructor
public class ChartController {

    public final TransactionService transactionService;

    @RequestMapping("transaction/index")
    public ModelAndView toTransactionIndex(ModelAndView modelAndView) {
        modelAndView.setViewName("workbench/chart/transaction/index");
        return modelAndView;
    }

    @RequestMapping("transaction/findCountOfGroupByStage")
    public Object findCountOfGroupByStage(){
        return transactionService.findCountOfGroupByStage();
    }
}
