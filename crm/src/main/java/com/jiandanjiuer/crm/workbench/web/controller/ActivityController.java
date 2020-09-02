package com.jiandanjiuer.crm.workbench.web.controller;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.DateUtils;
import com.jiandanjiuer.crm.commons.utils.UUIDUtils;
import com.jiandanjiuer.crm.settings.domain.User;
import com.jiandanjiuer.crm.settings.service.UserService;
import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.service.ActivityService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
    Object queryActivityForPageByCondition(Integer pageNo, Integer pageSize, String name,
                                           String owner, String startDate, String endDate) {
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

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    @RequestMapping("/workbench/activity/editActivity.do")
    public @ResponseBody
    Object queryActivity(String id) {
        return activityService.queryActivityById(id);
    }

    /**
     * 下载市场活动文件
     *
     * @param request
     * @param response
     */
    @RequestMapping("/workbench/activity/downloadsActivity")
    public void downloadsActivity(HttpServletRequest request, HttpServletResponse response) {
        //获取市场活动数据
        List<Activity> activityList = activityService.findActivityForDetail();
        downloadsActivityUtil(request, response, activityList);
    }

    //把市场活动数据封装成excel
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
    @RequestMapping("/workbench/activity/downloadsActivityByIds")
    public void downloadsActivityByIds(HttpServletRequest request, HttpServletResponse response, String[] ids) {
        //获取市场活动数据
        List<Activity> activityList = activityService.findActivityForDetailByIds(ids);
        downloadsActivityUtil(request, response, activityList);
    }

    /**
     * 上传市场活动
     *
     * @param myFile
     * @return json对象
     * @throws IOException 异常
     */
    @RequestMapping("/workbench/activity/fileupload")
    public @ResponseBody
    Object fileupload(MultipartFile myFile) throws IOException {
        HSSFWorkbook sheets = new HSSFWorkbook(myFile.getInputStream());

        return sheets;
    }

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
    @RequestMapping("/workbench/activity/saveCreateActivity.do")
    public @ResponseBody
    Object saveCreateActivity(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        //封装参数
        activity.setId(UUIDUtils.getUUID());
        activity.setCreateTime(DateUtils.formatDateTime(new Date()));
        activity.setCreateBy(user.getId());
        try {
            int i = activityService.saveCreateActivity(activity);

            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setMsg("数据保存失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setMsg("数据保存失败，出现异常");
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
    @RequestMapping("/updateActivityById")
    public @ResponseBody
    Object updateActivityById(HttpServletRequest request, Activity activity) {
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
    @RequestMapping("/removeActivityByIds")
    private @ResponseBody
    Object removeActivityByIds(String[] ids) {
        ReturnObject returnObject = new ReturnObject();
        int i = activityService.removeActivityByIds(ids);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setMsg("修改失败");
        }
        return returnObject;
    }
}
