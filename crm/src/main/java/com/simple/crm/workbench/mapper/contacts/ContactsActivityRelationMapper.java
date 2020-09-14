package com.simple.crm.workbench.mapper.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsActivityRelation;

import java.util.List;

/**
 * @author 24245
 */
public interface ContactsActivityRelationMapper {
    /**
     * 按主键删除
     *
     * @param id id
     * @return 删除条数
     */
    int deleteByPrimaryKey(String id);


    /**
     * 添加
     *
     * @param record 联系人活动关系对象
     * @return 添加条数
     */
    int insert(ContactsActivityRelation record);

    /**
     * 选择性添加
     *
     * @param record 联系人活动关系对象
     * @return 添加条数
     */
    int insertSelective(ContactsActivityRelation record);

    int insertContactsActivityRelationList(List<ContactsActivityRelation> contactsActivityRelationList);


    /**
     * 按主键查询
     *
     * @param id id
     * @return 联系人活动关系对象
     */
    ContactsActivityRelation selectByPrimaryKey(String id);


    /**
     * 按主键选择性更新
     *
     * @param record 联系人活动关系对象
     * @return 更新条数
     */
    int updateByPrimaryKeySelective(ContactsActivityRelation record);

    /**
     * 按主键更新
     *
     * @param record 联系人活动关系对象
     * @return 更新条数
     */
    int updateByPrimaryKey(ContactsActivityRelation record);

}