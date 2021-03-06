package com.simple.crm.commons.utils.webutil;

import com.simple.crm.commons.utils.otherutil.Md5Util;
import com.simple.crm.commons.utils.otherutil.StringOperating;
import com.simple.crm.commons.utils.otherutil.Unicode;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

/**
 * 百度翻译
 *
 * @author 简单
 * @date 2020/9/1
 */
public class BaiduTranslatorUtils {

    /**
     * 百度搜索URL
     */
    private final static String PreUrl = "https://fanyi-api.baidu.com/api/trans/vip/translate";
    /**
     * 翻译源语言
     */
    private final static String from = "auto";
    /**
     * 翻译目标语言
     */
    private final static String to = "zh";
    /**
     * APP ID
     */
    private final static String appId = "20200901000556957";
    /**
     * 平台分配的密钥
     */
    private final static String key = "B7zKm8BcqQblKKYSdt2X";

    /**
     * 传入要搜索的单词
     *
     * @param q 需要翻译的信息
     * @return 翻译后的信息
     * @throws Exception
     */
    public static String getTranslateResult(String q) throws Exception {
        //随机数
        String salt = String.valueOf(Math.random()).substring(2, 12);
        String a = appId + q + salt + key;
        String sign = Md5Util.getMd5(a);
        q = URLEncoder.encode(q, "gb2312");
        String url = PreUrl + "?q=" + q + "&from=" + from + "&to=" + to + "&appId=" + appId + "&salt=" + salt + "&sign=" + sign;
        String s = "";
        try {
            URL url1 = new URL(url);
            BufferedReader reader = new BufferedReader(new InputStreamReader(url1.openStream()));
            String line = "";
            while ((line = reader.readLine()) != null) {
//                System.out.println("网页内容：" + line);
                //前面的文本
                String left = "\"dst\":\"";
                //后面的文本
                String right = "\"}]}";
                String subString = StringOperating.getSubString(line, left, right);
                s = Unicode.unicodeDecode(subString);
                System.out.println("翻译后内容：" + s);
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return s;
    }

}