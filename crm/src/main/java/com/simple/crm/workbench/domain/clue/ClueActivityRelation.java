package com.simple.crm.workbench.domain.clue;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getClueId() {
        return clueId;
    }

    public void setClueId(String clueId) {
        this.clueId = clueId == null ? null : clueId.trim();
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId == null ? null : activityId.trim();
    }

}