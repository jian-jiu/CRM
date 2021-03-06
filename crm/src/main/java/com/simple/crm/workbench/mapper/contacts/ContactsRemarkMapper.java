package com.simple.crm.workbench.mapper.contacts;

import com.simple.crm.workbench.domain.contacts.ContactsRemark;

import java.util.List;

/**
 * @author 24245
 */
public interface ContactsRemarkMapper {
    /**
     * 按主键删除
     *
     * @param id id
     * @return 删除条数
     */
    int deleteByPrimaryKey(String id);

    int deleteByContactsId(String[] ids);


    /**
     * 添加
     *
     * @param record 联系人备注对象
     * @return 添加条数
     */
    int insert(ContactsRemark record);

    /**
     * 选择性添加
     *
     * @param record 联系人备注对象
     * @return 添加条数
     */
    int insertSelective(ContactsRemark record);


    /**
     * 按主键查询
     *
     * @param id id
     * @return 联系人备注对象
     */
    ContactsRemark selectByPrimaryKey(String id);

    ContactsRemark selectContactsRemarkForDetailById(String id);

    List<ContactsRemark> selectAllContactsRemarkForDetailByContactsId(String contactsId);


    /**
     * 按主键选择性更新
     *
     * @param record 联系人备注对象
     * @return 更新条数
     */
    int updateByPrimaryKeySelective(ContactsRemark record);

    /**
     * 按主键更新
     *
     * @param record 联系人备注对象
     * @return 更新条数
     */
    int updateByPrimaryKey(ContactsRemark record);

}