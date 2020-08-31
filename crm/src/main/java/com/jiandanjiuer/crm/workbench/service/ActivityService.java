package com.jiandanjiuer.crm.workbench.service;

import com.jiandanjiuer.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/17
 */
public interface ActivityService {

    /**
     * 保存创建的市场活动
     *
     * @param activity
     * @return
     */
    int saveCreateActivity(Activity activity);

    /**
     * 修改数据
     *
     * @param activity
     * @return
     */
    int modifyActivityById(Activity activity);

    /**
     * 根据条件分页查询数据
     *
     * @param map
     * @return
     */
    List<Activity> queryActivityForPageByCondition(Map<String, Object> map);

    /**
     * 查询详细的所有市场活动
     *
     * @return
     */
    List<Activity> findActivityForDetail();

    /**
     * 根据条件查询总条数
     *
     * @param map
     * @return
     */
    long queryCountOFActivityByCondition(Map<String, Object> map);

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    Activity queryActivityById(String id);

    /**
     * 根据多个id删除数据
     *
     * @param ids
     * @return
     */
    int removeActivityByIds(String[] ids);
}
