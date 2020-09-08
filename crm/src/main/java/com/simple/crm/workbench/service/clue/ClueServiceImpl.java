package com.simple.crm.workbench.service.clue;

import com.simple.crm.workbench.domain.clue.Clue;
import com.simple.crm.workbench.mapper.clue.ClueMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 简单
 * @date 2020/9/6
 */
@Service
@RequiredArgsConstructor
public class ClueServiceImpl implements ClueService {
    private final ClueMapper clueMapper;

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
     * 根据多个id删除线索
     *
     * @param ids 线索id数组
     * @return 删除条数
     */
    @Override
    public int removeClueByIds(String[] ids) {
        return clueMapper.deleteClueByIds(ids);
    }
}
