package com.jiandanjiuer.crm.workbench.domain.clue;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 线索备注
 *
 * @author 24245
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClueRemark implements Serializable {
    /**
     * id
     */
    private String id;

    /**
     * 备注内容
     */
    private String noteContent;

    /**
     * 创建者id
     */
    private String createBy;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 修改者id
     */
    private String editBy;

    /**
     * 修改时间
     */
    private String editTime;

    /**
     * 是否被修改
     */
    private String editFlag;

    /**
     * 线索id
     */
    private String clueId;
}