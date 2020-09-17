package com.simple.crm.workbench.web.controller.transaction;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.transaction.TransactionRemark;
import com.simple.crm.workbench.service.transaction.TransactionRemarkService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author 简单
 * @date 2020/9/17
 */
@RestController
@RequestMapping("/workbench/transaction/")
@RequiredArgsConstructor
public class TransactionRemarkController {

    private final TransactionRemarkService transactionRemarkService;

    private final HttpSession session;

    /**
     * 根据id查询详细的线索备注
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findTransactionRemarkById")
    public Object findTransactionRemarkById(String id) {
        TransactionRemark transactionRemark = transactionRemarkService.findTransactionRemarkForDetailById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(transactionRemark);
        return returnObject;
    }


    /**
     * 添加一条线索备注
     *
     * @param transactionRemark 线索备注对象
     * @return 结果集
     */
    @RequestMapping("addTransactionRemark")
    public Object addTransactionRemark(TransactionRemark transactionRemark) {
        //设置添加线索默认参数
        transactionRemark.setId(UUIDUtils.getUUID());
        transactionRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        if (transactionRemark.getCreateBy() == null || "".equals(transactionRemark.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            transactionRemark.setCreateBy(user.getId());
        }
        transactionRemark.setEditFlag("0");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = transactionRemarkService.addTransactionRemark(transactionRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                transactionRemark = transactionRemarkService.findTransactionRemarkForDetailById(transactionRemark.getId());
                returnObject.setData(transactionRemark);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败,出现异常");
        }
        return returnObject;
    }


    /**
     * 根据id更新线索备注
     *
     * @param transactionRemark 线索备注对象
     * @return 结果集
     */
    @RequestMapping("modifyTransactionRemark")
    public Object modifyTransactionRemark(TransactionRemark transactionRemark) {
        //设置更新参数
        transactionRemark.setEditTime(DateUtils.formatDateTime(new Date()));
        if (transactionRemark.getEditBy() == null || "".equals(transactionRemark.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            transactionRemark.setEditBy(user.getId());
        }
        transactionRemark.setEditFlag("1");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = transactionRemarkService.modifyTransactionRemark(transactionRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                transactionRemark = transactionRemarkService.findTransactionRemarkForDetailById(transactionRemark.getId());
                returnObject.setData(transactionRemark);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("修改失败,出现异常");
        }
        return returnObject;
    }


    /**
     * 根据id删除线索备注
     *
     * @param id id
     * @return 删除条数
     */
    @RequestMapping("removeTransactionRemarkById")
    public Object removeTransactionRemarkById(String id) {
        ReturnObject returnObject = new ReturnObject();
        int i = transactionRemarkService.removeTransactionRemarkById(id);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }
    
}
