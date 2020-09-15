package com.simple.crm.workbench.web.controller.customer;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.customer.CustomerRemark;
import com.simple.crm.workbench.service.customer.CustomerRemarkService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author 简单
 * @date 2020/9/14
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/customer/")
public class CustomerRemarkController {
    
    private final CustomerRemarkService customerRemarkService;
    
    private final HttpSession session;

    @RequestMapping("findCustomerRemark")
    public Object findCustomerRemark(String id) {
        CustomerRemark clueRemark = customerRemarkService.findCustomerRemarkForDetailById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(clueRemark);
        return returnObject;
    }


    @RequestMapping("saveCustomerRemark")
    public Object saveCustomerRemark(CustomerRemark customerRemark) {
        customerRemark.setId(UUIDUtils.getUUID());
        customerRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        if (customerRemark.getCreateBy() == null || "".equals(customerRemark.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            customerRemark.setCreateBy(user.getId());
        }
        customerRemark.setEditFlag("0");

        int i = customerRemarkService.saveCustomerRemark(customerRemark);

        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            customerRemark = customerRemarkService.findCustomerRemarkForDetailById(customerRemark.getId());
            returnObject.setData(customerRemark);
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败");
        }
        return returnObject;
    }


    @RequestMapping("modifyCustomerRemark")
    public Object modifyCustomerRemark(CustomerRemark customerRemark) {
        //设置更新参数
        customerRemark.setEditTime(DateUtils.formatDateTime(new Date()));
        if (customerRemark.getEditBy() == null || "".equals(customerRemark.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            customerRemark.setEditBy(user.getId());
        }
        customerRemark.setEditFlag("1");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = customerRemarkService.modifyCustomerRemark(customerRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                customerRemark = customerRemarkService.findCustomerRemarkForDetailById(customerRemark.getId());
                returnObject.setData(customerRemark);
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


    @RequestMapping("removeCustomerRemark")
    public Object removeCustomerRemark(String id) {
        ReturnObject returnObject = new ReturnObject();
        int i = customerRemarkService.removeCustomerRemark(id);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }
}
