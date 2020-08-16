package com.jiandanjiuer.crm.commons.utils;

import java.util.UUID;

/**
 * UUID工具类
 *
 * @author 简单
 * @date 2020/8/12
 */
public class UUIDUtils {

    /**
     * 返回一个32位的UUID字符串
     *
     * @return
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
