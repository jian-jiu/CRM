package com.jiandanjiuer.crm.commons.utils.otherutil;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间工具
 *
 * @author 简单
 * @date 2020/8/4 19:32
 */
public class DateUtils {
    /**
     * 时间初始化格式
     *
     * @param date 需要一个时间对象
     * @return 返回一个初始化格式之后的时间对象
     */
    public static String formatDateTime(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }
}
