package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.ClueRemark;
import com.simple.crm.workbench.mapper.clue.ClueRemarkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 线索备注
 *
 * @author 简单
 * @date 2020/9/8
 */
@Service
@RequiredArgsConstructor
public class ClueRemarkServiceImpl implements ClueRemarkService {

    private final ClueRemarkMapper clueRemarkMapper;

    /**
     * 根据id查询信息的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    @Override
    public ClueRemark findClueRemarkForDetailById(String id) {
        return clueRemarkMapper.selectClueRemarkForDetailById(id);
    }

    /**
     * 根据线索id查询详细的线索备注
     *
     * @param id id
     * @return 线索备注
     */
    @Override
    public List<ClueRemark> findClueRemarkForDetailByClueId(String id) {
        return clueRemarkMapper.selectClueRemarkForDetailByClueId(id);
    }

    /**
     * 条件一条线索备注
     *
     * @param clueRemark 线索备注对象
     * @return 添加条数
     */
    @Override
    public int addClueRemark(ClueRemark clueRemark) {
        return clueRemarkMapper.insertSelective(clueRemark);
    }

    /**
     * 选择性修改线索备注
     *
     * @param clueRemark 线索备注对象
     * @return 修改条数
     */
    @Override
    public int modifyClueRemark(ClueRemark clueRemark) {
        return clueRemarkMapper.updateByPrimaryKeySelective(clueRemark);
    }

    /**
     * 根据id删除线索备注
     *
     * @param id id
     * @return 删除条数
     */
    @Override
    public int removeClueRemarkById(String id) {
        return clueRemarkMapper.deleteByPrimaryKey(id);
    }
}
