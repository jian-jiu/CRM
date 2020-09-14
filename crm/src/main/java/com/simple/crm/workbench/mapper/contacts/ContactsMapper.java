package com.simple.crm.workbench.mapper.contacts;

import com.simple.crm.workbench.domain.contacts.Contacts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 24245
 */
public interface ContactsMapper {
    /**
     * 按主键删除
     *
     * @param id id
     * @return 删除条数
     */
    int deleteByPrimaryKey(String id);

    int deleteByMultiplePrimaryKey(String[] ids);


    /**
     * 添加
     *
     * @param record 联系人对象
     * @return 添加条数
     */
    int insert(Contacts record);

    /**
     * 选择性添加
     *
     * @param record 联系人对象
     * @return 添加条数
     */
    int insertSelective(Contacts record);


    /**
     * 按主键查询
     *
     * @param id id
     * @return 联系人对象
     */
    Contacts selectByPrimaryKey(String id);

    Contacts selectContactsDetailedCustomerIdById(String id);

    Contacts selectContactsForDetailById(String id);

    List<Contacts> selectPagingContactsForDetail(Map<String,Object> map);

    List<Contacts> selectContactsForDetailByName(String name);

    long selectCountContacts(HashMap<String, Object> map);


    /**
     * 按主键选择性更新
     *
     * @param record 联系人对象
     * @return 更新条数
     */
    int updateByPrimaryKeySelective(Contacts record);

    /**
     * 按主键更新
     *
     * @param record 联系人对象
     * @return 更新条数
     */
    int updateByPrimaryKey(Contacts record);

    int updateContactsSetNameIsEmptyByCustomerId(String[] customerIds);

}