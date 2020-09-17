package com.simple.crm.workbench.web.controller.transaction;

import com.simple.crm.workbench.service.transaction.TransactionHistoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 简单
 * @date 2020/9/17
 */
@RestController
@RequestMapping("/workbench/transaction/")
@RequiredArgsConstructor
public class TransactionHistoryController {

    private final TransactionHistoryService TransactionHistoryService;

    @RequestMapping("findTransactionHistoryForDetailByTranId")
    public Object findTransactionHistoryForDetailByTranId(String tranId) {
/*        List<TransactionHistory> transactionHistoryList = TransactionHistoryService.findForDetailByTranId(tranId);

        List<TransactionHistory> transactionHistoryListForDetail = new ArrayList<>();

        ResourceBundle resourceBundle = ResourceBundle.getBundle("possibility");

        if (transactionHistoryList != null || transactionHistoryList.size() > 0) {
            for (TransactionHistory transactionHistory : transactionHistoryList) {
                String string = resourceBundle.getString(transactionHistory.getStage());
                if ("".equals(string)) {
                    transactionHistory.setTranId("0");
                } else {
                    transactionHistory.setTranId(string);
                }
                transactionHistoryListForDetail.add(transactionHistory);
            }
        } else {
            transactionHistoryListForDetail = null;
        }
        return transactionHistoryListForDetail;*/
        return TransactionHistoryService.findForDetailByTranId(tranId);
    }
}
