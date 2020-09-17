package com.simple.crm.workbench.web.controller.customer;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.domain.customer.CustomerRemark;
import com.simple.crm.workbench.service.contacts.ContactsService;
import com.simple.crm.workbench.service.customer.CustomerRemarkService;
import com.simple.crm.workbench.service.customer.CustomerService;
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
 * 客户
 *
 * @author 简单
 * @date 2020/9/11
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/customer/")
public class CustomerController {

    private final CustomerService customerService;
    private final CustomerRemarkService customerRemarkService;

    private final ContactsService contactsService;

    private final HttpSession session;

    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        modelAndView.setViewName("workbench/customer/index");
        return modelAndView;
    }

    /**
     * 根据id查询客户详情
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findCustomerForDetailById")
    public ModelAndView findCustomerForDetailById(String id, ModelAndView modelAndView) {
        Customer customer = customerService.findCustomerForDetailById(id);
        List<CustomerRemark> customerRemarkList = customerRemarkService.findAllCustomerRemarkForDetailByCustomerId(id);
        List<Contacts> contactsList = contactsService.findContactsForDetailByCustomerId(id);

        modelAndView.addObject("customer", customer);
        modelAndView.addObject("customerRemarkList", customerRemarkList);
        modelAndView.addObject("contactsList", contactsList);
        modelAndView.setViewName("workbench/customer/detail");
        return modelAndView;
    }


    /**
     * 分页查询数据
     *
     * @param customer 客户对象
     * @param pageNo   当前页面
     * @param pageSize 每页数量
     * @return 结果集
     */
    @RequestMapping("findAllCustomerForDetail")
    public Object findAllCustomerForDetail(Customer customer, @RequestParam(defaultValue = "1") Integer pageNo,
                                           @RequestParam(defaultValue = "10") Integer pageSize) {
        HashMap<String, Object> map = new HashMap<>(3);

        map.put("customer", customer);
        map.put("beginNo", (pageNo - 1) * pageSize);
        map.put("pageSize", pageSize);

        List<Customer> customerList = customerService.findPagingCustomerForDetail(map);
        long totalRows = customerService.findCountCustomer(map);

        map.clear();
        map.put("customerList", customerList);
        map.put("totalRows", totalRows);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(map);
        return returnObject;
    }

    /**
     * 根据id查询客户
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findCustomerById")
    public Object findCustomerById(String id) {
        Customer customer = customerService.findCustomerById(id);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(customer);
        return returnObject;
    }

    /**
     * 根据客户id查询联系人数据
     *
     * @param customerId 客户id
     * @return 结果集
     */
    @RequestMapping("findCustomerByCustomerId")
    public Object findCustomerByCustomerId(String customerId) {
        List<Contacts> contactsList = contactsService.findContactsForDetailByCustomerId(customerId);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(contactsList);
        return returnObject;
    }

    /**
     * 查询所有客户名字
     *
     * @return 所有客户名字
     */
    @RequestMapping("findCustomerAllName")
    public Object findCustomerAllName() {
        return customerService.findAllName();
    }


    /**
     * 添加数据
     *
     * @param customer 客户对象
     * @return 结果集
     */
    @RequestMapping("addCustomer")
    public Object addCustomer(Customer customer) {
        ReturnObject returnObject = new ReturnObject();
        Customer customerByName = customerService.findCustomerByName(customer.getName());
        if (customerByName != null) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("客户名字重复了");
            return returnObject;
        }
        customer.setId(UUIDUtils.getUUID());
        if (customer.getCreateBy() == null || "".equals(customer.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            customer.setCreateBy(user.getId());
        }
        customer.setCreateTime(DateUtils.formatDateTime(new Date()));

        int i = customerService.saveContacts(customer);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败");
        }

        return returnObject;
    }


    /**
     * 根据id修改数据
     *
     * @param customer 客户对象
     * @return 结果集
     */
    @RequestMapping("updateCustomer")
    public Object updateCustomer(Customer customer) {
        customer.setEditTime(DateUtils.formatDateTime(new Date()));
        if (customer.getEditBy() == null || "".equals(customer.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            customer.setEditBy(user.getId());
        }

        int i = customerService.updateCustomerById(customer);

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
     * 根据多个主键删除数据
     *
     * @param ids id数组
     * @return 结果集
     */
    @RequestMapping("removeByMultiplePrimaryKeys")
    public Object removeByMultiplePrimaryKeys(String[] ids) {
        int i = customerService.removeByMultiplePrimaryKeys(ids);
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
