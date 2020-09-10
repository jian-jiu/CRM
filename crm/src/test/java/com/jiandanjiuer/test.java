package com.jiandanjiuer;

import org.junit.Test;

/**
 * @author 简单
 * @date 2020/9/1
 */
public class test {
    public static void main(String[] args) {
    }

    @Test
    public void string() {
        String a = "2020-9-4";
        String b = "2020-9-1";
        System.out.println(a.compareTo(b) > -1);
    }

    @Test
    public void test() {
        String str = "a,b,c,";
        String[] ary = str.split(",");
        //预期大于3，结果是3

        System.out.println(ary.length);

        for (String i : ary) {
            System.out.println(i);
        }
    }
}