package com.jiandanjiuer.crm.workbench.service.impl;

import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.mapper.ActivityMapper;
import com.jiandanjiuer.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/17
 */
@Service("activityService")
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * 保存创建的市场活动
     *
     * @param activity
     * @return
     */
    @Override
    public int saveCreateActivity(Activity activity) {
        System.out.println(activity);
        return activityMapper.insertActivity(activity);
    }

    /**
     * 根据条件分页查询数据
     *
     * @param map
     * @return
     */
    @Override
    public List<Activity> queryActivityForPageByCondition(Map<String, Object> map) {

        return activityMapper.selectActivityForPageByCondition(map);
    }

    /**
     * 根据条件查询总条数
     *
     * @param map
     * @return
     */
    @Override
    public long queryCountOFActivityByCondition(Map<String, Object> map) {
        return activityMapper.selectCountOActivityByCondition(map);
    }

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    @Override
    public Activity queryActivityById(String id) {
        return activityMapper.selectByPrimaryKey(id);
    }
}
