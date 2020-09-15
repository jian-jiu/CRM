package com.simple.crm.workbench.domain.clue;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getNoteContent() {
        return noteContent;
    }

    public void setNoteContent(String noteContent) {
        this.noteContent = noteContent == null ? null : noteContent.trim();
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy == null ? null : editBy.trim();
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime == null ? null : editTime.trim();
    }

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag == null ? null : editFlag.trim();
    }

    public String getClueId() {
        return clueId;
    }

    public void setClueId(String clueId) {
        this.clueId = clueId == null ? null : clueId.trim();
    }

}