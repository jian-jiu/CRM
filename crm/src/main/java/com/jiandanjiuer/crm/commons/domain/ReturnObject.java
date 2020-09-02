package com.jiandanjiuer.crm.commons.domain;

import com.jiandanjiuer.crm.commons.contants.Contents;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;


/**
 * 返回给前端的信息对象
 *
 * @author 简单
 * @date 2020/8/4 11:41
 */
@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReturnObject<T> {
    /**
     * 成功：1
     * 失败：0
     */
    private String code = Contents.RETURN_OBJECT_CODE_SUCCESS;

    /**
     * 描述信息
     */
    private String msg;
    /**
     * 返回对象
     */
    private T data;

    /**
     *
     * @return 默认结果集
     */
    public static Object getReturnObject() {
        return new ReturnObject<>();
    }

    /**
     *
     * @param code 结果
     * @return 自定义结果集
     */
    public static Object getReturnObject(String code) {
        return new ReturnObject<>(code);
    }

    /**
     *
     * @param code 结果
     * @param msg 结果信息
     * @return 自定义结果集
     */
    public static Object getReturnObject(String code, String msg) {
        return new ReturnObject<>(code, msg);
    }

    /**
     *
     * @param code 结果
     * @param msg 结果信息
     * @param data 结果数据内容
     * @return 自定义结果集
     */
    public static Object getReturnObject(String code, String msg, Object data) {
        return new ReturnObject<>(code, msg, data);
    }

    public ReturnObject(String code) {
        this.code = code;
    }

    public ReturnObject(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
