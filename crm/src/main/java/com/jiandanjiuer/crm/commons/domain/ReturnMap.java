package com.jiandanjiuer.crm.commons.domain;

import com.jiandanjiuer.crm.commons.contants.Contents;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.HashMap;

/**
 * @author 简单
 * @date 2020/9/4
 */
@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReturnMap extends HashMap {
    /**
     * 成功：1
     * 失败：0
     */
    private String code = Contents.RETURN_OBJECT_CODE_SUCCESS;

    /**
     * 描述信息
     */
    private String msg;
}
