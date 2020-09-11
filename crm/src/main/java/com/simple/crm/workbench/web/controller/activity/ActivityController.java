package com.simple.crm.workbench.web.controller.activity;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.commons.utils.settingsutil.UserUtil;
import com.simple.crm.commons.utils.workbenchutil.ActivityFileUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.settings.service.user.UserService;
import com.simple.crm.workbench.domain.activity.Activity;
import com.simple.crm.workbench.domain.activity.ActivityRemark;
import com.simple.crm.workbench.service.activity.ActivityRemarkService;
import com.simple.crm.workbench.service.activity.ActivityService;
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
    private final ActivityRemarkService activityRemarkService;

    /**
     * 转发到业务主页面携带用户数据
     *
     * @param modelAndView ModelAndView对象
     * @return 数据以及视图
     */
    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        modelAndView.setViewName("workbench/activity/index");
        return modelAndView;
    }

    /**
     * 根据id查询详细数据信息
     *
     * @param id 市场活动id
     * @return 数据以及视图
     */
    @RequestMapping("queryActivityToDataId")
    public ModelAndView queryActivityToDataIl(ModelAndView modelAndView, @RequestParam String id) {
        //查询数据
        Activity activity = activityService.findActivityForDetailById(id);
        List<ActivityRemark> activityRemarkList = activityRemarkService.findActivityRemarkForDetailByActivityId(activity.getId());
        //封装数据
        modelAndView.addObject("activity", activity);
        modelAndView.addObject("activityRemarkList", activityRemarkList);
        modelAndView.setViewName("workbench/activity/detail");
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
        Map<String, Object> map = new HashMap<>(6);
        map.put("beginNo", (pageNo - 1) * pageSize);
        map.put("pageSize", pageSize);
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        //查询数据
        List<Activity> activitiesList = activityService.queryActivityForPageByCondition(map);
        long totalRows = activityService.queryCountActivityByCondition(map);
        //响应信息
        map.clear();
        map.put("activitiesList", activitiesList);
        map.put("totalRows", totalRows);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(map);
        return returnObject;

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
        ReturnObject returnObject = new ReturnObject();
        if (activity != null) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            returnObject.setMessage("查询成功");
            returnObject.setData(activity);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("查询失败");
        }
        return returnObject;
    }

    /**
     * 选择性根据name查询详细的市场活动
     *
     * @param name 名称
     * @return 市场活动list集合
     */
    @RequestMapping("findActivityForDetailSelectiveByName")
    public Object findActivityForDetailSelectiveByName(String name, String clueId) {
        Map<String, Object> map = new HashMap<>(2);
        map.put("name", name);
        map.put("clueId", clueId);
        List<Activity> activityList = activityService.findActivityForDetailByOptionalNameAndClueId(map);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(activityList);
        return returnObject;
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

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = activityService.saveCreateActivity(activity);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("数据保存失败,出现异常");
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
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("更新失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("更新失败，出现异常");
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
     * @param request  请求
     * @param response 响应
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
                        userId = UserUtil.getUserId(users, cellValue);
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
                        userId = UserUtil.getUserId(users, cellValue);
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
                        userId = UserUtil.getUserId(users, cellValue);
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

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setMessage("成功添加条数");
        returnObject.setData(i);
        return returnObject;
    }
}
