package com.simple.crm.settings.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 字典值实体类
 *
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DicValue implements Serializable {

    private String id;

    private String value;

    private String text;

    private String orderNo;

    private String typeCode;
}