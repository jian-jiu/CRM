package com.simple.crm.workbench.service.clue;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.clue.Clue;
import com.simple.crm.workbench.domain.clue.ClueActivityRelation;
import com.simple.crm.workbench.domain.clue.ClueRemark;
import com.simple.crm.workbench.domain.contacts.Contacts;
import com.simple.crm.workbench.domain.contacts.ContactsActivityRelation;
import com.simple.crm.workbench.domain.contacts.ContactsRemark;
import com.simple.crm.workbench.domain.customer.Customer;
import com.simple.crm.workbench.domain.customer.CustomerRemark;
import com.simple.crm.workbench.domain.transaction.Transaction;
import com.simple.crm.workbench.mapper.clue.ClueActivityRelationMapper;
import com.simple.crm.workbench.mapper.clue.ClueMapper;
import com.simple.crm.workbench.mapper.clue.ClueRemarkMapper;
import com.simple.crm.workbench.mapper.contacts.ContactsActivityRelationMapper;
import com.simple.crm.workbench.mapper.contacts.ContactsMapper;
import com.simple.crm.workbench.mapper.contacts.ContactsRemarkMapper;
import com.simple.crm.workbench.mapper.customer.CustomerMapper;
import com.simple.crm.workbench.mapper.customer.CustomerRemarkMapper;
import com.simple.crm.workbench.mapper.transaction.TransactionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 简单
 * @date 2020/9/6
 */
@Service
@RequiredArgsConstructor
public class ClueServiceImpl implements ClueService {

    /**
     * 线索
     */
    private final ClueMapper clueMapper;
    private final ClueRemarkMapper clueRemarkMapper;
    private final ClueActivityRelationMapper clueActivityRelationMapper;

    /**
     * 客户
     */
    private final CustomerMapper customerMapper;
    private final CustomerRemarkMapper customerRemarkMapper;


    /**
     * 联系人
     */
    private final ContactsMapper contactsMapper;
    private final ContactsRemarkMapper contactsRemarkMapper;
    private final ContactsActivityRelationMapper contactsActivityRelationMapper;

    /**
     * 交易
     */
    private final TransactionMapper transactionMapper;

    private final HttpSession session;

    /**
     * 转换线索
     *
     * @param map map
     */
    @Override
    public void saveConvert(Map<String, Object> map) {
        String clueId = (String) map.get("clueId");

        User user = (User) session.getAttribute(Contents.SESSION_USER);

        //根据线索id查询线索
        Clue clue = clueMapper.selectByPrimaryKey(clueId);
        //获取客户是否存在
        Customer customer = customerMapper.selectCustomerByName(clue.getCompany());
        //把线索里面的公司信息保存到客户表中
        if (customer == null) {
            customer = new Customer();
            customer.setId(UUIDUtils.getUUID());
            customer.setOwner(clue.getOwner());
            customer.setName(clue.getCompany());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setCreateBy(user.getId());
            customer.setCreateTime(DateUtils.formatDateTime(new Date()));
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());
            customer.setAddress(clue.getAddress());
            customerMapper.insertSelective(customer);
        } else {
            customer.setOwner(clue.getOwner());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setEditBy(user.getId());
            customer.setEditTime(DateUtils.formatDateTime(new Date()));
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());
            customer.setAddress(clue.getAddress());
            customerMapper.updateByPrimaryKeySelective(customer);
        }

        //把线索里面的联系人信息保存到联系人表中
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtils.getUUID());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullName(clue.getFullName());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setCellPhone(clue.getCellPhone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(user.getId());
        contacts.setCreateTime(DateUtils.formatDateTime(new Date()));
        contacts.setDescription(clue.getDescription());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());
        contactsMapper.insertSelective(contacts);

        //根据线索id查询线索备注信息
        List<ClueRemark> clueRemarkList = clueRemarkMapper.selectByClueId(clueId);
        if (clueRemarkList != null) {
            for (ClueRemark clueRemark : clueRemarkList) {
                //把线索备注信息转换到客户备注信息中
                CustomerRemark customerRemark = new CustomerRemark();
                customerRemark.setId(UUIDUtils.getUUID());
                customerRemark.setNoteContent(clueRemark.getNoteContent());
                customerRemark.setCreateBy(clueRemark.getCreateBy());
                customerRemark.setCreateTime(clueRemark.getCreateTime());
                customerRemark.setEditBy(clueRemark.getEditBy());
                customerRemark.setEditTime(clueRemark.getEditTime());
                customerRemark.setEditFlag(clueRemark.getEditFlag());
                customerRemark.setCustomerId(customer.getId());
                customerRemarkMapper.insertSelective(customerRemark);

                //把线索备注信息转换到联系人备注信息中
                ContactsRemark contactsRemark = new ContactsRemark();
                contactsRemark.setId(UUIDUtils.getUUID());
                contactsRemark.setNoteContent(clueRemark.getNoteContent());
                contactsRemark.setCreateBy(clueRemark.getCreateBy());
                contactsRemark.setCreateTime(clueRemark.getCreateTime());
                contactsRemark.setEditBy(clueRemark.getEditBy());
                contactsRemark.setEditTime(clueRemark.getEditTime());
                contactsRemark.setEditFlag(clueRemark.getEditFlag());
                contactsRemark.setContactsId(contacts.getId());
                contactsRemarkMapper.insertSelective(contactsRemark);
            }
        }
        //根据线索id查询线索和市场活动关系数据
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationMapper.selectByClueId(clueId);
        if (clueActivityRelationList != null) {
            for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
                //把线索和市场活动关系并转换到联系人和市场活动关系表中
                ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
                contactsActivityRelation.setId(UUIDUtils.getUUID());
                contactsActivityRelation.setContactsId(contacts.getId());
                contactsActivityRelation.setActivityId(clueActivityRelation.getActivityId());
                contactsActivityRelationMapper.insertSelective(contactsActivityRelation);
            }
        }

        //是否需要创建交易信息
        String isCreateTransaction = (String) map.get("isCreateTransaction");
        if ("true".equals(isCreateTransaction)) {
            System.out.println("创建交易");
            Transaction transaction = new Transaction();
            transaction.setId(UUIDUtils.getUUID());
            transaction.setOwner(clue.getOwner());
            transaction.setMoney(String.valueOf(map.get("amountOfMoney")));
            transaction.setName(String.valueOf(map.get("tradeName")));
            transaction.setExpectedDate(String.valueOf(map.get("expectedClosingDate")));
            transaction.setCustomerId(customer.getId());
            transaction.setStage(String.valueOf(map.get("stage")));
            transaction.setActivityId(String.valueOf(map.get("activity")));
            transaction.setContactsId(contacts.getId());
            transaction.setCreateBy(user.getId());
            transaction.setCreateTime(DateUtils.formatDateTime(new Date()));
            transactionMapper.insertSelective(transaction);
        }
        //删除有关线索内容
        String[] clueIds = {clueId};
        clueRemarkMapper.deleteByClueId(clueIds);
        clueActivityRelationMapper.deleteByClueId(clueIds);
        clueMapper.deleteClueByIds(clueIds);
        System.out.println("转换结束");
    }

    /**
     * 根据id查询线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    @Override
    public Clue findClueById(String id) {
        return clueMapper.selectByPrimaryKey(id);
    }

    /**
     * 根据线索id查询详细的线索
     *
     * @param id 线索id
     * @return 线索对象
     */
    @Override
    public Clue findClueForDetailById(String id) {
        return clueMapper.selectClueForDetailById(id);
    }

    /**
     * 分页查询
     *
     * @param clue     线索对象
     * @param beginNo  第几页开始
     * @param pageSize 每页条数
     * @return 线索list集合
     */
    @Override
    public List<Clue> findPagingForDetailClue(Clue clue, Integer beginNo, Integer pageSize) {
        return clueMapper.selectPagingForDetailClue(clue, beginNo, pageSize);
    }

    /**
     * 根据条件查询线索总数量
     *
     * @param clue 线索对象
     * @return 线索数量
     */
    @Override
    public long findCountPagingClue(Clue clue) {
        return clueMapper.selectCountPagingClue(clue);
    }


    /**
     * 添加线索
     *
     * @param clue 线索对象
     * @return 成功条数
     */
    @Override
    public int addClue(Clue clue) {
        return clueMapper.insertSelective(clue);
    }


    /**
     * 根据线索id更新线索
     *
     * @param clue 线索对象
     * @return 修改提数
     */
    @Override
    public int modifyClueById(Clue clue) {
        return clueMapper.updateByPrimaryKeySelective(clue);
    }


    /**
     * 根据多个id删除线索,删除线索备注,并且删除线索和市场活动关系数据
     *
     * @param ids 线索id数组
     * @return 删除条数
     */
    @Override
    public int removeClueByIds(String[] ids) {
        clueRemarkMapper.deleteByClueId(ids);
        clueActivityRelationMapper.deleteByClueId(ids);
        return clueMapper.deleteClueByIds(ids);
    }
}
