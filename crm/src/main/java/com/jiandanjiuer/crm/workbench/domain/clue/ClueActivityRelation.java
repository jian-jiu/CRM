package com.jiandanjiuer.crm.workbench.domain.clue;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 线索活动关系
 *
 * @author 24245
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClueActivityRelation implements Serializable {
    /**
     * id
     */
    private String id;

    /**
     * 线索id
     */
    private String clueId;

    /**
     * 市场活动id
     */
    private String activityId;
}