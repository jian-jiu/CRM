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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo == null ? null : orderNo.trim();
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode == null ? null : typeCode.trim();
    }
}