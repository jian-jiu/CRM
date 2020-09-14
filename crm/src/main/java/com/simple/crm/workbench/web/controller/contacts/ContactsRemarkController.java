package com.simple.crm.workbench.web.controller.contacts;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.contacts.ContactsRemark;
import com.simple.crm.workbench.service.contacts.ContactsRemarkService;
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
@RequestMapping("/workbench/contacts/")
@RequiredArgsConstructor
public class ContactsRemarkController {

    private final ContactsRemarkService contactsRemarkService;

    private final HttpSession session;

    /**
     * 根据id查询详细的联系人备注
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findContactsRemark")
    public Object findContactsRemark(String id) {
        ContactsRemark clueRemark = contactsRemarkService.findContactsRemarkForDetailById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(clueRemark);
        return returnObject;
    }


    /**
     * 添加一条联系人备注
     *
     * @param contactsRemark 联系人备注
     * @return 结果集
     */
    @RequestMapping("saveContactsRemark")
    public Object saveContactsRemark(ContactsRemark contactsRemark) {
        contactsRemark.setId(UUIDUtils.getUUID());
        contactsRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        if (contactsRemark.getCreateBy() == null || "".equals(contactsRemark.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            contactsRemark.setCreateBy(user.getId());
        }
        contactsRemark.setEditFlag("0");

        int i = contactsRemarkService.saveContactsRemark(contactsRemark);

        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            contactsRemark = contactsRemarkService.findContactsRemarkForDetailById(contactsRemark.getId());
            returnObject.setData(contactsRemark);
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败");
        }
        return returnObject;
    }

    /**
     * 根据id更新联系人备注
     *
     * @param contactsRemark 线索备注对象
     * @return 结果集
     */
    @RequestMapping("modifyContactsRemark")
    public Object modifyContactsRemark(ContactsRemark contactsRemark) {
        //设置更新参数
        contactsRemark.setEditTime(DateUtils.formatDateTime(new Date()));
        if (contactsRemark.getEditBy() == null || "".equals(contactsRemark.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            contactsRemark.setEditBy(user.getId());
        }
        contactsRemark.setEditFlag("1");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = contactsRemarkService.modifyContactsRemark(contactsRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                contactsRemark = contactsRemarkService.findContactsRemarkForDetailById(contactsRemark.getId());
                returnObject.setData(contactsRemark);
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
     * 根据id删除联系人备注
     *
     * @param id id
     * @return 删除条数
     */
    @RequestMapping("removeContactsRemark")
    public Object removeContactsRemark(String id) {
        ReturnObject returnObject = new ReturnObject();
        int i = contactsRemarkService.removeContactsRemark(id);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }
}
