package com.jiandanjiuer.crm.workbench.service;

import com.jiandanjiuer.crm.workbench.domain.ActivityRemark;

import java.util.List;

/**
 * 市场活动业务接口
 *
 * @author 简单
 * @date 2020/9/4
 */
public interface ActivityRemarkService {

    /**
     * 根据市场活动id查询市场活动备注
     *
     * @param id 市场活动id
     * @return 市场活动备注list集合
     */
    List<ActivityRemark> findActivityRemarkByActivityId(String id);

    /**
     * 添加市场活动备注
     *
     * @param activityRemark 市场活动备注对象
     * @return 添加条数
     */
    int addActivityRemark(ActivityRemark activityRemark);
}
