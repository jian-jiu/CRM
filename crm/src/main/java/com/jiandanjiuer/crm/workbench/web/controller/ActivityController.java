package com.jiandanjiuer.crm.workbench.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.DateUtils;
import com.jiandanjiuer.crm.commons.utils.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/16
 */
@Controller
public class ActivityController {

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ReturnObject returnObject;

    /**
     * 转发到业务主页面
     *
     * @param model
     * @return
     */
    @RequestMapping("/workbench/activity/index.do")
    public String index(Model model) {
        List<User> usersList = userService.queryAllUsers();
        model.addAttribute("usersList", usersList);
        return "workbench/activity/index";
    }

    /**
     * 保存创建的参数
     *
     * @param activity
     * @param session
     * @return
     */
    @RequestMapping("/workbench/activity/saveCreateActivity.do")
    public @ResponseBody
    Object saveCreateActivity(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        //封装参数
        activity.setId(UUIDUtils.getUUID());
        activity.setCreateTime(DateUtils.formatDateTime(new Date()));
        activity.setCreateBy(user.getId());

        System.out.println(session.getId());
        System.out.println(user.getId());

        try {


            int i = activityService.saveCreateActivity(activity);

            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setMessage("数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setMessage("数据保存失败，出现异常");
        }
        return returnObject;
    }

    /**
     * 根据数据分页查询数据
     *
     * @param pageNo
     * @param pageSize
     * @param name
     * @param owner
     * @param startDate
     * @param endDate
     * @return
     */
    @RequestMapping("/workbench/activity/queryActivityForPageByCondition.do")
    public @ResponseBody
    Object queryActivityForPageByCondition(Integer pageNo, Integer pageSize,
                                           String name, String owner,
                                           String startDate, String endDate) {
        //封装参数
        Map<String, Object> map = new HashMap();
        map.put("beginNo", (pageNo - 1) * pageSize);
        map.put("pageSize", pageSize);
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        //查询数据
        List<Activity> activitiesList = activityService.queryActivityForPageByCondition(map);
        long totalRows = activityService.queryCountOFActivityByCondition(map);
        //响应信息
        Map<String, Object> retMap = new HashMap();
        retMap.put("activitiesList", activitiesList);
        retMap.put("totalRows", totalRows);

        return retMap;
    }

    @RequestMapping("/workbench/activity/editActivity.do")
    public @ResponseBody
    Object editActivity(String id) {
        Activity activity = activityService.queryActivityById(id);
        return activity;
    }
}
