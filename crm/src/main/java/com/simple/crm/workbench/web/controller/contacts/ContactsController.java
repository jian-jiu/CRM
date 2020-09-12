package com.simple.crm.workbench.web.controller.contacts;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.service.contacts.ContactsService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author 简单
 * @date 2020/9/11
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/contacts/")
public class ContactsController {

    private final ContactsService contactsService;

    private final HttpSession session;

    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView){
        modelAndView.setViewName("workbench/contacts/index");
        return modelAndView;
    }


    @RequestMapping("addContacts")
    public Object addContacts(Contacts contacts) {
        contacts.setId(UUIDUtils.getUUID());
        if (contacts.getCreateBy() == null || "".equals(contacts.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            contacts.setCreateBy(user.getId());
        }
        contacts.setCreateTime(DateUtils.formatDateTime(new Date()));

        System.out.println(contacts);

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
}
