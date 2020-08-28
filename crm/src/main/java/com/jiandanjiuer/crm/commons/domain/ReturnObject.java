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
public class ReturnObject {
    /**
     * 成功：1
     * 失败：0
     */
    private String code = Contents.RETURN_OBJECT_CODE_FAIL;
    /**
     * 描述信息
     */
    private String message;
    /**
     * 返回对象
     */
    private Object retData;

    /**
     * 设置code的时候进行初始化参数
     *
     * @param code
     */
    public void setCode(String code) {
        message = null;
        retData = null;
        this.code = code;
    }
}
