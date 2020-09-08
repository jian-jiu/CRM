package com.simple.crm.commons.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 返回给前端的信息对象
 *
 * @author 简单
 * @date 2020/8/4 11:41
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReturnObject {
    /**
     * 执行结果
     */
    private String code;

    /**
     * 描述信息
     */
    private String message;

    /**
     * 返回数据
     */
    private Object data;
}
