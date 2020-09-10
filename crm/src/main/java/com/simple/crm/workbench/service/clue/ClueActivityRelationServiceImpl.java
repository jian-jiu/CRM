package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.ClueActivityRelation;
import com.simple.crm.workbench.mapper.clue.ClueActivityRelationMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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
     * 根据list线索关系对象添加数据
     *
     * @param clueActivityRelationList 线索关系list对象
     * @return 添加条数
     */
    @Override
    public int addClueActivityRelation(List<ClueActivityRelation> clueActivityRelationList) {
        return clueActivityRelationMapper.insertClueActivityRelationList(clueActivityRelationList);
    }
}
