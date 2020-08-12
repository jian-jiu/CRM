package com.jiandanjiuer.crm.commons.domain;

import com.jiandanjiuer.crm.commons.contants.Contants;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * 返回给前端的信息对象
 * @author 简单
 * @date 2020/8/4 11:41
 */
@Service("returnObject")
public class ReturnObject {
    /**
     * 成功：1
     * 失败：0
     */
    private String code = Contants.RETURN_OBJECT_CODE_FAIL;
    /**
     * 描述信息
     */
    private String message;
    /**
     * 返回对象
     */
    private Object retData;

    public ReturnObject() {
    }

    public ReturnObject(String code, String message, Object retData) {
        this.code = code;
        this.message = message;
        this.retData = retData;
    }

    @Override
    public String toString() {
        return "ReturnObject{" +
                "code='" + code + '\'' +
                ", message='" + message + '\'' +
                ", retData=" + retData +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReturnObject that = (ReturnObject) o;
        return Objects.equals(code, that.code) &&
                Objects.equals(message, that.message) &&
                Objects.equals(retData, that.retData);
    }

    @Override
    public int hashCode() {
        return Objects.hash(code, message, retData);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getRetData() {
        return retData;
    }

    public void setRetData(Object retData) {
        this.retData = retData;
    }
}
