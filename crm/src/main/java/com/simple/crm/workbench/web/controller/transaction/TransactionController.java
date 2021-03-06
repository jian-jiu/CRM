package com.simple.crm.workbench.web.controller.transaction;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.DicValue;
import com.simple.crm.settings.domain.User;
import com.simple.crm.settings.service.dicvalue.DicValueService;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.domain.transaction.Transaction;
import com.simple.crm.workbench.domain.transaction.TransactionRemark;
import com.simple.crm.workbench.service.contacts.ContactsService;
import com.simple.crm.workbench.service.customer.CustomerService;
import com.simple.crm.workbench.service.transaction.TransactionRemarkService;
import com.simple.crm.workbench.service.transaction.TransactionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 交易
 *
 * @author 简单
 * @date 2020/9/11
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/transaction/")
public class TransactionController {

    private final TransactionService transactionService;
    private final TransactionRemarkService transactionRemarkService;

    private final DicValueService dicValueService;

    private final CustomerService customerService;

    private final ContactsService contactsService;

    private final HttpSession session;

    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        List<Customer> customerList = customerService.findCustomerForDetail();
        List<Contacts> contactsList = contactsService.findContactsForDetail();

        modelAndView.addObject("customerList", customerList);
        modelAndView.addObject("contactsList", contactsList);
        modelAndView.setViewName("workbench/transaction/index");
        return modelAndView;
    }

    @RequestMapping("saveIndex")
    public ModelAndView saveIndex(ModelAndView modelAndView) {
        modelAndView.setViewName("workbench/transaction/save");
        return modelAndView;
    }

    /**
     * 根据id查询详细的交易详细
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findTransactionForDetailByPrimaryKeyToDetail")
    public ModelAndView findTransactionForDetailByPrimaryKeyToDetail(String id, ModelAndView modelAndView) {
        Transaction transaction = transactionService.findForDetailByPrimaryKey(id);
        transaction.setPossibility(getPossibilityByStageValue(transaction.getStage()));
        List<TransactionRemark> transactionRemarkList = transactionRemarkService.findForDetailByTranId(id);
        List<DicValue> stageList = dicValueService.findDicValueByDicType("stage");

        modelAndView.addObject("transaction", transaction);
        modelAndView.addObject("transactionRemarkList", transactionRemarkList);
        modelAndView.addObject("stageList", stageList);
        modelAndView.setViewName("workbench/transaction/detail");
        return modelAndView;
    }

    /**
     * 分页查询交易信息
     *
     * @param pageNo
     * @param pageSize
     * @param owner
     * @param name
     * @param customerId
     * @param stage
     * @param type
     * @param source
     * @param contactsId
     * @return
     */
    @RequestMapping("findPagingForDetail")
    public Object findPagingForDetail(@RequestParam(defaultValue = "1") Integer pageNo,
                                      @RequestParam(defaultValue = "10") Integer pageSize,
                                      String owner, String name, String customerId,
                                      String stage, String type, String source, String contactsId) {
        Map<String, Object> map = new HashMap<>(9);
        map.put("beginNo", (pageNo - 1) * pageSize);
        map.put("pageSize", pageSize);
        map.put("owner", owner);
        map.put("name", name);
        map.put("customerId", customerId);
        map.put("stage", stage);
        map.put("type", type);
        map.put("source", source);
        map.put("contactsId", contactsId);

        List<Transaction> transactionList = transactionService.findPagingForDetail(map);
        long totalRows = transactionService.findCount(map);

        map.clear();
        map.put("transactionList", transactionList);
        map.put("totalRows", totalRows);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(map);
        return returnObject;
    }


    /**
     * 添加一条交易记录
     *
     * @param transaction 交易对象
     * @return 结果集
     */
    @RequestMapping("insertTransaction")
    public Object insertTransaction(Transaction transaction) {
        transaction.setId(UUIDUtils.getUUID());
        if (transaction.getCreateBy() == null || "".equals(transaction.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            transaction.setCreateBy(user.getId());
        }
        transaction.setCreateTime(DateUtils.formatDateTime(new Date()));

        int i = transactionService.insertSelective(transaction);

        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败");
        }
        return returnObject;
    }


    @RequestMapping("updateTransactionStage")
    public Object updateTransactionStage(Transaction transaction) {
        transaction.setEditTime(DateUtils.formatDateTime(new Date()));
        if (transaction.getEditBy() == null || "".equals(transaction.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            transaction.setEditBy(user.getId());
        }

        transactionService.updateByPrimaryKey(transaction);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        return returnObject;
    }


    /**
     * 根据多个主键id删除数据
     *
     * @param ids id数组
     * @return 结果集
     */
    @RequestMapping("removeTransactionByPrimaryKeys")
    public Object removeTransactionByPrimaryKeys(String[] ids) {
        int i = transactionService.removeByPrimaryKeys(ids);

        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }


    /**
     * 获取配置文件内容
     *
     * @param stageValue
     * @return
     */
    @RequestMapping("getPossibilityByStageValue")
    public String getPossibilityByStageValue(String stageValue) {
        try {
            ResourceBundle possibility = ResourceBundle.getBundle("possibility");
            return possibility.getString(stageValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
