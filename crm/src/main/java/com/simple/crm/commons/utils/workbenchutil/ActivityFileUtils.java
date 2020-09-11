package com.simple.crm.commons.utils.workbenchutil;

import com.simple.crm.workbench.domain.activity.Activity;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * 市场活动文件工具类
 *
 * @author 简单
 * @date 2020/9/3
 */
public class ActivityFileUtils {

    /**
     * 把市场活动数据封装成excel
     *
     * @param request      请求
     * @param response     响应
     * @param activityList 市场活动集合
     */
    public static void downloadsActivityUtil(HttpServletRequest request, HttpServletResponse response, List<Activity> activityList) {
        //设置响应类型
        response.setContentType("application/octet-stream:charset=UTF-8");

        ServletOutputStream outputStream;
//        InputStream inputStream = null;
//        HSSFWorkbook wb = null;
        try (HSSFWorkbook wb = new HSSFWorkbook()) {
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
//            wb = new HSSFWorkbook();
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
            ///刷新流
            outputStream.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
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

}
