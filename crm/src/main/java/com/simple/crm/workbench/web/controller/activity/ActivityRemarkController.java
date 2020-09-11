package com.simple.crm.workbench.web.controller.activity;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.activity.ActivityRemark;
import com.simple.crm.workbench.service.activity.ActivityRemarkService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * 市场活动控制层
 *
 * @author 简单
 * @date 2020/9/4
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/activity/")
public class ActivityRemarkController {

    private final ActivityRemarkService activityRemarkService;
    public final HttpSession session;

    /**
     * 根据id查询市场活动备注
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findActivityRemarkById")
    public Object findActivityRemarkById(String id) {
        ActivityRemark activityRemark = activityRemarkService.findActivityRemarkById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(activityRemark);
        return returnObject;
    }

    /**
     * 添加市场活动
     *
     * @param activityRemark 市场活动
     * @return 结果集
     */
    @RequestMapping("addActivityRemark")
    public Object addActivityRemark(ActivityRemark activityRemark) {
        //设置参数
        activityRemark.setId(UUIDUtils.getUUID());
        //设置创建时间
        activityRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        //获取当前用户
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        activityRemark.setCreateBy(user.getId());
        activityRemark.setEditFlag("0");

        //添加市场活动备注
        ReturnObject returnObject = new ReturnObject();
        try {
            int i = activityRemarkService.addActivityRemark(activityRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                activityRemark = activityRemarkService.findActivityRemarkForDetailById(activityRemark.getId());
                returnObject.setData(activityRemark);
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
     * 修改市场活动备注
     *
     * @param activityRemark 市场活动备注对象
     * @return 结果集
     */
    @RequestMapping("updateActivityRemarkById")
    public Object updateActivityRemarkById(ActivityRemark activityRemark) {
        activityRemark.setEditTime(DateUtils.formatDateTime(new Date()));

        User user = (User) session.getAttribute(Contents.SESSION_USER);
        activityRemark.setEditBy(user.getId());

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = activityRemarkService.updateActivityRemarkById(activityRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                activityRemark = activityRemarkService.findActivityRemarkForDetailById(activityRemark.getId());
                returnObject.setData(activityRemark);
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
     * 根据id删除市场活动备注
     *
     * @param id id
     * @return 删除条数
     */
    @RequestMapping("removeActivityRemark")
    public Object removeActivityRemark(String id) {
        int i = activityRemarkService.removeActivityRemark(id);
        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败,出现异常");
        }
        return returnObject;
    }

}
