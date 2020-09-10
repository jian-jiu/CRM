package com.simple.crm.workbench.web.controller;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.workbench.domain.activity.Activity;
import com.simple.crm.workbench.domain.clue.ClueActivityRelation;
import com.simple.crm.workbench.service.activity.ActivityService;
import com.simple.crm.workbench.service.clue.ClueActivityRelationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 简单
 * @date 2020/9/9
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/activity/")
public class ClueActivityRelationController {

    private final ClueActivityRelationService clueActivityRelationService;
    private final ActivityService activityService;

    @RequestMapping("removeByPrimaryKey")
    public Object removeByPrimaryKey(String id) {
        int i = clueActivityRelationService.removeByPrimaryKey(id);
        ReturnObject returnObject = new ReturnObject();
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }

    /**
     * 选择性根据name添加线索市场关系数据
     *
     * @param clueId      线索id
     * @param activityIds 市场id数组
     * @return 结果集
     */
    @RequestMapping("addClueActivityRelation")
    public Object addClueActivityRelation(String clueId, String[] activityIds) {
        List<ClueActivityRelation> clueActivityRelationList = new ArrayList<>();
        for (String activityId : activityIds) {
            clueActivityRelationList.add(new ClueActivityRelation(UUIDUtils.getUUID(), clueId, activityId));
        }
        int i = clueActivityRelationService.addClueActivityRelation(clueActivityRelationList);
        List<Activity> activityList = activityService.findActivityByClueId(clueId);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setMessage("成功关联" + i + "条市场活动");
        returnObject.setData(activityList);
        return returnObject;
    }
}
