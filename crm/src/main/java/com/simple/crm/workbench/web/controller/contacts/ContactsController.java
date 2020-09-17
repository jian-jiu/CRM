package com.simple.crm.workbench.web.controller.contacts;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.activity.Activity;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.domain.contacts.ContactsRemark;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.service.activity.ActivityService;
import com.simple.crm.workbench.service.contacts.ContactsRemarkService;
import com.simple.crm.workbench.service.contacts.ContactsService;
import com.simple.crm.workbench.service.customer.CustomerService;
import com.simple.crm.workbench.service.transaction.TransactionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author 简单
 * @date 2020/9/11
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/contacts/")
public class ContactsController {

    private final ContactsService contactsService;
    private final ContactsRemarkService contactsRemarkService;

    private final CustomerService customerService;

    private final ActivityService activityService;

    private final TransactionService transactionService;

    private final HttpSession session;

    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        List<Customer> customerList = customerService.findCustomerForDetail();

        modelAndView.addObject("customerList",customerList);
        modelAndView.setViewName("workbench/contacts/index");
        return modelAndView;
    }

    /**
     * 根据id查询详细的联系人
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findContactsForDetailByIdToView")
    public ModelAndView findContactsForDetailByIdToView(String id, ModelAndView modelAndView) {
        Contacts contacts = contactsService.findContactsForDetailById(id);
        List<ContactsRemark> contactsRemarkList = contactsRemarkService.findAllContactsRemarkForDetailByContactsId(id);
        List<Activity> activityList = activityService.findActivityByContactsId(id);

        modelAndView.addObject("contacts", contacts);
        modelAndView.addObject("contactsRemarkList", contactsRemarkList);
        modelAndView.addObject("activityList", activityList);
        modelAndView.setViewName("workbench/contacts/detail");
        return modelAndView;
    }

    /**
     * 分页查询联系人详情
     *
     * @param contacts 联系人对象
     * @param pageNo   当前页面
     * @param pageSize 每页数量
     * @return 结果集
     */
    @RequestMapping("findPagingContactsForDetail")
    public Object findPagingContactsForDetail(Contacts contacts, @RequestParam(defaultValue = "1") Integer pageNo,
                                              @RequestParam(defaultValue = "10") Integer pageSize) {
        HashMap<String, Object> map = new HashMap<>(3);

        map.put("contacts", contacts);
        map.put("beginNo", (pageNo - 1) * pageSize);
        map.put("pageSize", pageSize);

        List<Contacts> contactsList = contactsService.findPagingContactsForDetail(map);
        long totalRows = contactsService.findCountContacts(map);

        map.clear();
        map.put("contactsList", contactsList);
        map.put("totalRows", totalRows);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(map);
        return returnObject;
    }

    /**
     * 根据id查询联系人详细的客户
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findContactsDetailedCustomerIdById")
    public Object findContactsDetailedCustomerIdById(String id) {
        Contacts contacts = contactsService.findContactsDetailedCustomerIdById(id);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(contacts);
        return returnObject;
    }

    /**
     * 根据名字查询信息的联系人
     *
     * @param name 名字
     * @return 结果集
     */
    @RequestMapping("findContactsForDetailByName")
    public Object findContactsForDetailByName(String name) {
        List<Contacts> contactsList = contactsService.findContactsForDetailByName(name);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(contactsList);
        return returnObject;
    }

    /**
     * 根据id查询交易信息
     *
     * @param id id
     * @return 和客户有关的交易信息
     */
    @RequestMapping("findTransactionForDetailById")
    public Object findTransactionForDetailById(String id) {
        return transactionService.findForDetailByContactsId(id);
    }



    /**
     * 添加联系人
     *
     * @param contacts 联系人
     * @return 结果集
     */
    @RequestMapping("addContacts")
    public Object addContacts(Contacts contacts) {
        contacts.setId(UUIDUtils.getUUID());
        if (contacts.getCreateBy() == null || "".equals(contacts.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            contacts.setCreateBy(user.getId());
        }
        contacts.setCreateTime(DateUtils.formatDateTime(new Date()));

        ReturnObject returnObject = new ReturnObject();
        int i = contactsService.addContacts(contacts);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败");
        }
        return returnObject;
    }

    /**
     * 修改联系人
     *
     * @param contacts 联系人对象
     * @return 结果集
     */
    @RequestMapping("updateByPrimaryKeySelective")
    public Object updateByPrimaryKeySelective(Contacts contacts) {
        contacts.setEditTime(DateUtils.formatDateTime(new Date()));
        if (contacts.getEditBy() == null || "".equals(contacts.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            contacts.setEditBy(user.getId());
        }

        int i = contactsService.updateByPrimaryKeySelective(contacts);
        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("修改失败");
        }
        return returnObject;
    }


    /**
     * 根据多个id删除数据
     *
     * @param ids id数组
     * @return 结果集
     */
    @RequestMapping("removeByMultiplePrimaryKey")
    public Object removeByMultiplePrimaryKey(String[] ids) {
        int i = contactsService.removeByMultiplePrimaryKey(ids);

        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }
}
