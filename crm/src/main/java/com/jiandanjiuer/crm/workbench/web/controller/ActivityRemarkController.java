package com.jiandanjiuer.crm.workbench.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.otherutil.DateUtils;
import com.jiandanjiuer.crm.commons.utils.otherutil.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import com.jiandanjiuer.crm.workbench.domain.ActivityRemark;
import com.jiandanjiuer.crm.workbench.service.ActivityRemarkService;
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
    private final UserService userService;

    public final HttpSession session;

    @RequestMapping("addActivityRemark")
    public Object addActivityRemark(ActivityRemark activityRemark) {
        //设置参数
        activityRemark.setId(UUIDUtils.getUUID());
        //设置创建时间
        activityRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        //获取当前用户
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        activityRemark.setCreateBy(user.getId());

        System.out.println(activityRemark);

        //添加市场活动备注
        Object returnObject;
        try {
            int i = activityRemarkService.addActivityRemark(activityRemark);
            if (i > 0) {
                returnObject = ReturnObject.getReturnObject();
            } else {
                returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "添加失败,出现异常");
        }
        return returnObject;
    }
}
