package com.simple.crm.workbench.mapper.activity;

import com.simple.crm.workbench.domain.activity.Activity;

import java.util.List;
import java.util.Map;

/**
 * @author 24245
 */
public interface ActivityMapper {

    int deleteByPrimaryKey(String id);

    int insert(Activity record);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Activity record);

    int updateByPrimaryKey(Activity record);


    /**
     * 根据条件分页查询数据
     *
     * @param map 需要map
     * @return 返回分页的所有市场活动集合
     */
    List<Activity> selectActivityForPageByCondition(Map<String, Object> map);

    /**
     * 查询详细的所有市场活动
     *
     * @return 详细市场活动集合
     */
    List<Activity> selectActivityForDetail();

    /**
     * 根据多个id查询详细的所有市场活动
     *
     * @param ids id数组
     * @return 详细市场活动集合
     */
    List<Activity> selectActivityForDetailByIds(String[] ids);

    /**-
     * 根据name查询详细的市场活动
     *
     * @param map 封装参数后的map
     * @return 未关联此线索id的市场活动list集合
     */
    List<Activity> selectActivityForDetailByOptionalNameAndClueId(Map<String, Object> map);

    /**
     * 根据线索id查询关联的市场活动
     *
     * @param clueId 线索id
     * @return 市场活动list集合
     */
    List<Activity> selectActivityByClueId(String clueId);

    /**
     * 根据条件查询总条数
     *
     * @param map map
     * @return 总条数
     */
    long selectCountActivityByCondition(Map<String, Object> map);


    /**
     * 保存创建的市场活动
     *
     * @param activity 市场活动对象
     * @return 添加条数
     */
    int insertActivity(Activity activity);

    /**
     * 保存创建的多个市场活动
     *
     * @param activity 市场活动对象
     * @return 添加条数
     */
    int insertActivityByList(List<Activity> activity);


    /**
     * 修改数据
     *
     * @param activity 市场活动对象
     * @return 修改条数
     */
    int updateByPrimaryId(Activity activity);


    /**
     * 根据多个id删除数据
     *
     * @param ids id数组
     * @return 删除条数
     */
    int deleteActivityByIds(String[] ids);


}