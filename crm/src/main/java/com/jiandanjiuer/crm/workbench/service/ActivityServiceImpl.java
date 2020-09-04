package com.jiandanjiuer.crm.workbench.service;

import com.jiandanjiuer.crm.workbench.domain.Activity;
import com.jiandanjiuer.crm.workbench.mapper.ActivityMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/17
 */
@Service("activityService")
@RequiredArgsConstructor
public class ActivityServiceImpl implements ActivityService {

    private final ActivityMapper activityMapper;

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
     * 查询详细的所有市场活动
     *
     * @return
     */
    @Override
    public List<Activity> findActivityForDetail() {
        return activityMapper.selectActivityForDetail();
    }

    /**
     * 根据多个id查询详细的所有市场活动
     *
     * @param ids id数组
     * @return 详细市场活动集合
     */
    @Override
    public List<Activity> findActivityForDetailByIds(String[] ids) {
        return activityMapper.selectActivityForDetailByIds(ids);
    }

    @Override
    public Activity findActivityForDetailById(String id) {
        String[] ids = new String[1];
        ids[0] = id;
        List<Activity> activityList = activityMapper.selectActivityForDetailByIds(ids);
        return activityList.get(0);
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
     * 保存创建的多个市场活动
     *
     * @param activityList 市场活动对象
     * @return 添加条数
     */
    @Override
    public int modifyActivityList(List<Activity> activityList) {
        return activityMapper.insertActivityByList(activityList);
    }


    /**
     * 修改市场活动数据
     *
     * @param activity
     * @return
     */
    @Override
    public int modifyActivityById(Activity activity) {
        return activityMapper.updateByPrimaryId(activity);
    }


    /**
     * 根据多个id删除数据
     *
     * @param ids
     * @return
     */
    @Override
    public int removeActivityByIds(String[] ids) {
        return activityMapper.deleteActivityByIds(ids);
    }
}
