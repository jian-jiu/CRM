package com.jiandanjiuer.crm.workbench.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.ActivityFileUtils;
import com.jiandanjiuer.crm.commons.utils.DateUtils;
import com.jiandanjiuer.crm.commons.utils.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.service.ActivityService;
import com.jiandanjiuer.crm.workbench.service.impl.ActivityServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * @author 简单
 * @date 2020/8/16
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/activity/")
public class ActivityController {

    private final UserService userService;
    private final ActivityService activityService;

    /**
     * 转发到业务主页面携带用户数据
     *
     * @param modelAndView ModelAndView对象
     * @return 数据以及视图
     */
    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        //获取用户信息
        List<User> usersList = userService.queryAllUsers();
        modelAndView.addObject("usersList", usersList);
        modelAndView.setViewName("workbench/activity/index");
        return modelAndView;
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
    @PostMapping("queryActivityForPageByCondition")
    public Object queryActivityForPageByCondition(@RequestParam(defaultValue = "1") Integer pageNo,
                                                  @RequestParam(defaultValue = "10") Integer pageSize,
                                                  String name, String owner, String startDate, String endDate) {
        //封装参数
        Map<String, Object> map = new HashMap(6);
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
        map.clear();
        map.put("activitiesList", activitiesList);
        map.put("totalRows", totalRows);
        return ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_SUCCESS, "成功", map);

    }

    /**
     * 根据id查询数据
     *
     * @param id 市场活动id
     * @return 结果集
     */
    @RequestMapping("editActivity")
    public Object queryActivity(@RequestParam String id) {
        Activity activity = activityService.queryActivityById(id);
        Object returnObject;
        if (activity != null) {
            returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_SUCCESS, "查询成功", activity);
        } else {
            returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "查询失败");
        }
        return returnObject;
    }

    /**
     * 根据id查询详细数据信息
     *
     * @param id 市场活动id
     * @return 数据以及视图
     */
    @RequestMapping("queryActivityToDataIl")
    public ModelAndView queryActivityToDataIl(ModelAndView modelAndView, @RequestParam String id) {
        //查询数据
        Activity activity = activityService.findActivityForDetailById(id);
        //封装数据
        modelAndView.addObject("activity", activity);
        modelAndView.setViewName("workbench/activity/detail");
        return modelAndView;
    }

    /**
     * 下载市场活动文件
     *
     * @param request  请求
     * @param response 响应
     */
    @RequestMapping("downloadsActivity")
    public void downloadsActivity(HttpServletRequest request, HttpServletResponse response) {
        //获取市场活动数据
        List<Activity> activityList = activityService.findActivityForDetail();
        ActivityFileUtils.downloadsActivityUtil(request, response, activityList);
    }

    /**
     * 根据多个id下载市场活动文件
     *
     * @param request
     * @param response
     */
    @RequestMapping("downloadsActivityByIds")
    public void downloadsActivityByIds(HttpServletRequest request, HttpServletResponse response, String[] ids) {
        //获取市场活动数据
        List<Activity> activityList = activityService.findActivityForDetailByIds(ids);
        ActivityFileUtils.downloadsActivityUtil(request, response, activityList);
    }

    /**
     * 上传市场活动
     *
     * @param activityFile 市场活动文件
     * @param session      会话
     * @return 结果集
     * @throws IOException 异常
     */
    @RequestMapping("fileupload")
    public Object importActivity(MultipartFile activityFile, HttpSession session) throws IOException {
        //获取文件对象
        HSSFWorkbook wb = new HSSFWorkbook(activityFile.getInputStream());
        //获取页对象
        HSSFSheet sheetAt = wb.getSheetAt(0);
        //获取所有用户数据
        List<User> users = userService.queryAllUsers();
        //获取当前导入用户
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        //行
        HSSFRow row;
        //id
        String userId;
        List<Activity> activityList = new ArrayList<>();
        //获取行
        for (int i = 1; i <= sheetAt.getLastRowNum(); i++) {
            row = sheetAt.getRow(i);
            //判断日期
            String startDate = ActivityFileUtils.getCellValue(row.getCell(2));
            String endDate = ActivityFileUtils.getCellValue(row.getCell(3));
            if ("".equals(startDate) && !"".equals(endDate)) {
                //日期比较结果
                if (startDate.compareTo(endDate) < 0) {
                    continue;
                }
            }
            //创建对象
            Activity activity = new Activity();
            activity.setId(UUIDUtils.getUUID());
            //获取每行数据
            for (int j = 0; j < row.getLastCellNum(); j++) {
                String cellValue = ActivityFileUtils.getCellValue(row.getCell(j));
                switch (j) {
                    case 0:
                        userId = ActivityServiceImpl.getUserId(users, cellValue);
                        if (userId == null) {
                            activity.setOwner(user.getId());
                        } else {
                            activity.setOwner(userId);
                        }
                        break;
                    case 1:
                        activity.setName(cellValue);
                        break;
                    case 2:
                        activity.setStartDate(cellValue);
                        break;
                    case 3:
                        activity.setEndDate(cellValue);
                        break;
                    case 4:
                        activity.setCost(cellValue);
                        break;
                    case 5:
                        activity.setDescription(cellValue);
                        break;
                    case 6:
                        activity.setCreateTime(cellValue);
                        break;
                    case 7:
                        userId = ActivityServiceImpl.getUserId(users, cellValue);
                        if (userId == null) {
                            activity.setCreateBy(user.getId());
                        } else {
                            activity.setCreateBy(userId);
                        }
                        break;
                    case 8:
                        activity.setEditTime(cellValue);
                        break;
                    case 9:
                        userId = ActivityServiceImpl.getUserId(users, cellValue);
                        if (userId == null) {
                            activity.setEditBy(user.getId());
                        } else {
                            activity.setEditBy(userId);
                        }
                        break;
                }
            }
            activityList.add(activity);
        }
        int i = activityService.modifyActivityList(activityList);
        return ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_SUCCESS, "成功添加条数", i);
    }

    /**
     * 保存创建的参数
     *
     * @param activity
     * @param session
     * @return
     */
    @PostMapping("saveCreateActivity")
    public Object saveCreateActivity(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        //封装参数
        activity.setId(UUIDUtils.getUUID());
        activity.setCreateTime(DateUtils.formatDateTime(new Date()));
        activity.setCreateBy(user.getId());

        Object returnObject;
        try {
            int i = activityService.saveCreateActivity(activity);
            if (i > 0) {
                returnObject = ReturnObject.getReturnObject();
            } else {
                returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "数据保存失败，出现异常");
        }
        return returnObject;
    }


    /**
     * 修改市场活动数据
     *
     * @param request
     * @param activity
     * @return
     */
    @PostMapping("updateActivityById")
    public Object updateActivityById(HttpServletRequest request, Activity activity) {
        //设置修改时间和修改者id
        activity.setEditTime(DateUtils.formatDateTime(new Date()));
        User user = (User) request.getSession().getAttribute(Contents.SESSION_USER);
        activity.setEditBy(user.getId());

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = activityService.modifyActivityById(activity);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setMsg("更新失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setMsg("更新失败，出现异常");
        }
        return returnObject;
    }


    /**
     * 根据多个id删除数据
     *
     * @param ids
     * @return
     */
    @RequestMapping("removeActivityByIds")
    private Object removeActivityByIds(String[] ids) {
        int i = activityService.removeActivityByIds(ids);
        Object returnObject;
        if (i > 0) {
            returnObject = ReturnObject.getReturnObject();
        } else {
            returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "修改失败");
        }
        return returnObject;
    }
}
