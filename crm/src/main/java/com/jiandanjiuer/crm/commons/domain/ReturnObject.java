package com.jiandanjiuer.crm.commons.domain;

import com.jiandanjiuer.crm.commons.contants.Contants;
import lombok.Data;

/**
 * @author 简单
 * @date 2020/8/4 11:41
 */
@Data
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
}
