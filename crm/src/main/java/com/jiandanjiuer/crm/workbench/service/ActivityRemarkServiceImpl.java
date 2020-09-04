package com.jiandanjiuer.crm.workbench.service;

import com.jiandanjiuer.crm.workbench.domain.ActivityRemark;
import com.jiandanjiuer.crm.workbench.mapper.ActivityRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 市场活动业务层
 *
 * @author 简单
 * @date 2020/9/4
 */
@Service
@RequiredArgsConstructor
public class ActivityRemarkServiceImpl implements ActivityRemarkService {

    private final ActivityRemarkMapper activityRemarkMapper;

    /**
     * 根据市场活动id查询市场活动备注
     *
     * @param id 市场活动id
     * @return 市场活动备注list集合
     */
    @Override
    public List<ActivityRemark> findActivityRemarkByActivityId(String id) {
        return activityRemarkMapper.selectActivityRemarkForDetailByActivityId(id);
    }

    /**
     * 添加市场活动备注
     *
     * @param activityRemark 市场活动备注对象
     * @return 添加条数
     */
    @Override
    public int addActivityRemark(ActivityRemark activityRemark) {
        return activityRemarkMapper.insertSelective(activityRemark);

    }
}
