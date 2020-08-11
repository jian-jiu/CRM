package com.jiandanjiuer.crm.commons.utils;

import javax.xml.crypto.Data;
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
     * 时间初始化
     *
     * @param date
     * @return
     */
    public static String formatDateTime(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        return sdf.format(date);
    }
}
