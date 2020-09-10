package com.simple.crm.workbench.service.clue;

import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.workbench.domain.clue.ClueActivityRelation;
import com.simple.crm.workbench.mapper.clue.ClueActivityRelationMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author 简单
 * @date 2020/9/9
 */
@Service
@RequiredArgsConstructor
public class ClueActivityRelationServiceImpl implements ClueActivityRelationService {

    private final ClueActivityRelationMapper clueActivityRelationMapper;

    /**
     * 根据id删除数据
     *
     * @param id id
     * @return 市场条数
     */
    @Override
    public int removeByPrimaryKey(String id) {
        return clueActivityRelationMapper.deleteByPrimaryKey(id);
    }

    /**
     * 添加线索市场活动关系
     *
     * @param clueId      线索id
     * @param activityIds 市场活动id
     * @return 添加条数
     */
    @Override
    public int addClueActivityRelation(String clueId, String[] activityIds) {
        ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
        clueActivityRelation.setClueId(clueId);
        int i = 0;
        for (String activityId : activityIds) {
            ClueActivityRelation clueActivityRelation1 = clueActivityRelationMapper.selectClueActivityRelationByActivity(activityId);
            System.out.println("=====================");
            System.out.println(clueActivityRelation1);
            if (clueActivityRelation1 == null) {
                clueActivityRelation.setId(UUIDUtils.getUUID());
                clueActivityRelation.setActivityId(activityId);
                int insert = clueActivityRelationMapper.insert(clueActivityRelation);
                if (insert == 1) {
                    i++;
                }
            }
        }
        return i;
    }
}
