package com.jiandanjiuer.crm.commons.utils.otherutil;

import java.util.UUID;

/**
 * UUID工具类
 *
 * @author 简单
 * @date 2020/8/12
 */
public class UUIDUtils {

    /**
     * 生成一个32位的UUID字符串
     *
     * @return 返回一个32位的UUID字符串
     */
    public static String getUUID() {
        //对生成的UUID进行字符替换
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
