package com.jiandanjiuer.crm.settings.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 数据字典实体类
 *
 * @author 24245
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class DicType implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_dic_type.code
     *
     * @mbggenerated Fri Aug 07 19:52:34 CST 2020
     */
    private String code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_dic_type.name
     *
     * @mbggenerated Fri Aug 07 19:52:34 CST 2020
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_dic_type.description
     *
     * @mbggenerated Fri Aug 07 19:52:34 CST 2020
     */
    private String description;
}