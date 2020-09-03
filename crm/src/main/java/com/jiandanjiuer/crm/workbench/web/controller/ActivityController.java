package com.jiandanjiuer.crm.workbench.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.DateUtils;
import com.jiandanjiuer.crm.commons.utils.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.service.ActivityService;
import lombok.RequiredArgsConstructor;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
     * @param id
     * @return
     */
    @RequestMapping("editActivity")
    public Object queryActivity(@RequestParam String id) {
        return activityService.queryActivityById(id);
    }


    /**
     * 下载市场活动文件
     *
     * @param request
     * @param response
     */
    @RequestMapping("downloadsActivity")
    public void downloadsActivity(HttpServletRequest request, HttpServletResponse response) {
        //获取市场活动数据
        List<Activity> activityList = activityService.findActivityForDetail();
        downloadsActivityUtil(request, response, activityList);
    }

    /**
     * 把市场活动数据封装成excel
     *
     * @param request      请求
     * @param response     响应
     * @param activityList 市场活动集合
     */
    private void downloadsActivityUtil(HttpServletRequest request, HttpServletResponse response, List<Activity> activityList) {
        //设置响应类型
        response.setContentType("application/octet-stream:charset=UTF-8");

        ServletOutputStream outputStream;
//        InputStream inputStream = null;
        HSSFWorkbook wb = null;
        try {
            //用来获取浏览器信息进行判断编码格式
            String userAgent = request.getHeader("User-Agent");
            System.out.println(userAgent);
            //根据编码设置下载文件名字
            String fileName = new String("学生列表".getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
            //设置响应头信息
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName + ".xls");
            //2 获取输出流
            outputStream = response.getOutputStream();
            //1 创建对象，对应一个excel对象
            wb = new HSSFWorkbook();
            //2 使用wb对象创建一页
            HSSFSheet sheet = wb.createSheet("市场活动列表");
            //3 第一行标题
            HSSFRow row = sheet.createRow(0);
            //4 设置每列标题内容
            row.createCell(0).setCellValue("所有者");
            row.createCell(1).setCellValue("活动名称");
            row.createCell(2).setCellValue("开始时间");
            row.createCell(3).setCellValue("结束时间");
            row.createCell(4).setCellValue("成本");
            row.createCell(5).setCellValue("描述");
            row.createCell(6).setCellValue("创建时间");
            row.createCell(7).setCellValue("创建者");
            row.createCell(8).setCellValue("修改时间");
            row.createCell(9).setCellValue("修改者");
            //设置每行内容
            if (activityList != null) {
                for (int i = 0; i < activityList.size(); i++) {
                    //获取每行对象
                    HSSFRow rowI = sheet.createRow(i + 1);
                    //获取每条市场对象
                    Activity activity = activityList.get(i);
                    //设置每列内容z
                    rowI.createCell(0).setCellValue(activity.getOwner());
                    rowI.createCell(1).setCellValue(activity.getName());
                    rowI.createCell(2).setCellValue(activity.getStartDate());
                    rowI.createCell(3).setCellValue(activity.getEndDate());
                    rowI.createCell(4).setCellValue(activity.getCost());
                    rowI.createCell(5).setCellValue(activity.getDescription());
                    rowI.createCell(6).setCellValue(activity.getCreateTime());
                    rowI.createCell(7).setCellValue(activity.getCreateBy());
                    rowI.createCell(8).setCellValue(activity.getEditTime());
                    rowI.createCell(9).setCellValue(activity.getEditBy());
                }
            }
            wb.write(outputStream);

            //读取文件
                /*inputStream = new FileInputStream("D:/test/abc.xls");
                //设置每次读取数据大小
                byte[] bytes = new byte[1024];
                //当前读取数据的大小
                int len = 0;
                while ((len = inputStream.read(bytes)) != -1) {
                    //把数据输出到浏览器
                    outputStream.write(bytes, 0, len);
                }*/
            //刷新流
            outputStream.flush();
        } catch (
                IOException e) {
            e.printStackTrace();
        } finally {
            /*if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }*/
            if (wb != null) {
                try {
                    wb.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
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
        downloadsActivityUtil(request, response, activityList);
    }

    /**
     * 查询传过来的用户id
     *
     * @param users    用户list集合
     * @param username 查询用户
     * @return 用户id
     */
    public String getUserId(List<User> users, String username) {
        for (User user : users) {
            if (username.equals(user.getName())) {
                return user.getId();
            }
        }
        return null;
    }

    /**
     * 上传市场活动
     *
     * @param activityFile 市场活动文件
     * @return json对象
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
            String startDate = getCellValue(row.getCell(2));
            String endDate = getCellValue(row.getCell(3));
            if ("".equals(startDate) && !"".equals(endDate)) {
                //日期比较结果
                System.out.println("开始: " + startDate + "结束: " + endDate + "   " + startDate.compareTo(endDate));
                if (startDate.compareTo(endDate) < 0) {
                    continue;
                }
            }

            //创建对象
            Activity activity = new Activity();
            activity.setId(UUIDUtils.getUUID());
            //获取每行数据
            for (int j = 0; j < row.getLastCellNum(); j++) {
                String cellValue = getCellValue(row.getCell(j));
                switch (j) {
                    case 0:
                        userId = getUserId(users, cellValue);
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
                        userId = getUserId(users, cellValue);
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
                        userId = getUserId(users, cellValue);
                        if (userId == null) {
                            activity.setEditBy(user.getId());
                        } else {
                            activity.setEditBy(userId);
                        }
                        break;
                }
            }
            System.out.println("activity:  " + activity);
            activityList.add(activity);
        }
        int i = activityService.insertActivityList(activityList);
        return ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_SUCCESS, "成功添加条数", i);
    }

    /**
     * 转换每个单元格数据为字符串
     *
     * @param cell 一行数据对象
     * @return 字符串
     */
    public static String getCellValue(HSSFCell cell) {
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case BOOLEAN:
                return cell.getBooleanCellValue() + "";
            case NUMERIC:
                return cell.getNumericCellValue() + "";
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
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
