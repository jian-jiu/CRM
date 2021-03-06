package com.simple.crm.commons.utils.otherutil;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Unicode转换
 *
 * @author 简单
 * @date 2020/9/1
 */
public class Unicode {

    /**
     * 中文转Unicode
     *
     * @param string 中文字符串
     * @return Unicode编码
     */
    public static String unicodeEncode(String string) {
        char[] utfBytes = string.toCharArray();
        String unicodeBytes = "";
        for (int i = 0; i < utfBytes.length; i++) {
            String hexB = Integer.toHexString(utfBytes[i]);
            if (hexB.length() <= 2) {
                hexB = "00" + hexB;
            }
            unicodeBytes = unicodeBytes + "\\u" + hexB;
        }
        return unicodeBytes;
    }

    /**
     * Unicode转中文
     *
     * @param string Unicode编码
     * @return 中文字符串
     */
    public static String unicodeDecode(String string) {
        Pattern pattern = Pattern.compile("(\\\\u(\\p{XDigit}{4}))");
        Matcher matcher = pattern.matcher(string);
        char ch;
        while (matcher.find()) {
            ch = (char) Integer.parseInt(matcher.group(2), 16);
            string = string.replace(matcher.group(1), ch + "");
        }
        return string;
    }
}
