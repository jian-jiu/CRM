package com.jiandanjiuer.poi;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * 使用poi测试生成excel
 *
 * @author 简单
 * @date 2020/8/29
 */
public class CreateExcelTest {
    public static void main(String[] args) throws FileNotFoundException, IOException {
        //1 创建对象，对应一个excel对象
        HSSFWorkbook wb = new HSSFWorkbook();
        //2 使用wb对象创建一页
        HSSFSheet sheet = wb.createSheet("学生列表");
        HSSFSheet sheet1 = wb.createSheet("测试页面");
        //3 使用sheet创建行
        //行的编号，默认0开始
        HSSFRow row = sheet.createRow(0);
        HSSFRow row1 = sheet1.createRow(0);
        //使用row对象创建列
        row.createCell(0).setCellValue("id");
        row.createCell(1).setCellValue("姓名");
        row.createCell(2).setCellValue("班级");
        row.createCell(3).setCellValue("年龄");

        row1.createCell(0).setCellValue("测试0");
        row1.createCell(1).setCellValue("测试1");
        row1.createCell(2).setCellValue("测试2");
        row1.createCell(3).setCellValue("测试3");

        //创建cellStyle对象，对应样式
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HorizontalAlignment.CENTER);

        for (int i = 1; i <= 10; i++) {
            row = sheet.createRow(i);
            HSSFCell cell = row.createCell(0);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(i);
            row.createCell(1).setCellValue("姓名：" + i);
            row.createCell(2).setCellValue("班级" + i);
            row.createCell(3).setCellValue("年龄" + i);
        }
        for (int i = 1; i <= 10; i++) {
            row1 = sheet1.createRow(i);
            row1.createCell(0).setCellValue("0：" + i);
            row1.createCell(1).setCellValue("1：" + i);
            row1.createCell(2).setCellValue("2" + i);
            row1.createCell(3).setCellValue("3" + i);
        }

        OutputStream outputStream = new FileOutputStream("D:/test/abc.xls");

        wb.write(outputStream);

        outputStream.flush();
        outputStream.close();
        wb.close();
    }
}
