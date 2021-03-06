package com.simple.crm.workbench.service.activity;

import com.simple.crm.workbench.domain.activity.Activity;

import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/8/17
 */
public interface ActivityService {

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     */
    Activity queryActivityById(String id);

    /**
     * 根据id查询详细的市场活动
     *
     * @param id 市场活动id
     * @return 详细市场活动集合
     */
    Activity findActivityForDetailById(String id);

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
     * @return 详细的市场活动集合
     */
    List<Activity> findActivityForDetail();

    /**
     * 根据多个id查询详细的所有市场活动
     *
     * @param ids id数组
     * @return 详细市场活动集合
     */
    List<Activity> findActivityForDetailByIds(String[] ids);

    List<Activity> findActivityForDetailByOptionalName(String name);

    /**
     * 根据name查询详细的市场活动
     *
     * @param map 封装参数后的map
     * @return 未关联此线索id的市场活动list集合
     */
    List<Activity> findActivityForDetailByOptionalNameAndClueId(Map<String, Object> map);

    List<Activity> findActivityForDetailByOptionalNameAndContactsId(Map<String, Object> map);

    /**
     * 根据线索id查询关联的市场活动
     *
     * @param clueId 线索id
     * @return 市场活动list集合
     */
    List<Activity> findActivityByClueId(String clueId);

    List<Activity> findActivityByContactsId(String contactsId);

    /**
     * 根据条件查询总条数
     *
     * @param map
     * @return
     */
    long queryCountActivityByCondition(Map<String, Object> map);


    /**
     * 保存创建的市场活动
     *
     * @param activity
     * @return
     */
    int saveCreateActivity(Activity activity);


    /**
     * 保存创建的多个市场活动
     *
     * @param activityList 市场活动对象
     * @return 添加条数
     */
    int modifyActivityList(List<Activity> activityList);

    /**
     * 修改数据
     *
     * @param activity
     * @return
     */
    int modifyActivityById(Activity activity);


    /**
     * 根据多个id删除数据
     *
     * @param ids
     * @return
     */
    int removeActivityByIds(String[] ids);

}
