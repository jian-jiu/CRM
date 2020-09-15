package com.simple.crm.workbench.web.controller.contacts;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.workbench.domain.activity.Activity;
import com.simple.crm.workbench.domain.contacts.ContactsActivityRelation;
import com.simple.crm.workbench.service.activity.ActivityService;
import com.simple.crm.workbench.service.contacts.ContactsActivityRelationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 简单
 * @date 2020/9/14
 */
@RestController
@RequestMapping("/workbench/contacts/")
@RequiredArgsConstructor
public class ContactsActivityRelationController {

    private final ContactsActivityRelationService contactsActivityRelationService;
    private final ActivityService activityService;

    /**
     * 按主键删除
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("removeByPrimaryKey")
    public Object removeByPrimaryKey(String id) {
        int i = contactsActivityRelationService.removeByPrimaryKey(id);
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
     * 选择性根据name添加线索市场关系数据
     *
     * @param contactsId  联系人id
     * @param activityIds 市场id数组
     * @return 结果集
     */
    @RequestMapping("addContactsActivityRelation")
    public Object addContactsActivityRelation(String contactsId, String[] activityIds) {
        List<ContactsActivityRelation> contactsActivityRelationList = new ArrayList<>();
        for (String activityId : activityIds) {
            contactsActivityRelationList.add(new ContactsActivityRelation(UUIDUtils.getUUID(), contactsId, activityId));
        }
        int i = contactsActivityRelationService.addContactsActivityRelation(contactsActivityRelationList);
        List<Activity> activityList = activityService.findActivityByContactsId(contactsId);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setMessage("成功关联" + i + "条市场活动");
        returnObject.setData(activityList);
        return returnObject;
    }
}
