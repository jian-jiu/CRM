package com.simple.crm.workbench.web.controller.clue;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.activity.Activity;
import com.simple.crm.workbench.domain.clue.Clue;
import com.simple.crm.workbench.domain.clue.ClueRemark;
import com.simple.crm.workbench.service.activity.ActivityService;
import com.simple.crm.workbench.service.clue.ClueRemarkService;
import com.simple.crm.workbench.service.clue.ClueService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 线索控制层
 *
 * @author 简单
 * @date 2020/9/6
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/clue/")
public class ClueController {

    private final ClueService clueService;
    private final ClueRemarkService clueRemarkService;
    private final ActivityService activityService;

    private final HttpSession session;

    /**
     * 跳转到线索界面
     *
     * @param modelAndView 数据和视图
     * @return 数据和视图
     */
    @RequestMapping("index")
    public ModelAndView index(ModelAndView modelAndView) {
        modelAndView.setViewName("workbench/clue/index");
        return modelAndView;
    }

    /**
     * 根据线索id查询信息的线索
     *
     * @param id           线索id
     * @param modelAndView 数据以及视图
     * @return 数据以及视图
     */
    @RequestMapping("findClueForDetailById")
    public ModelAndView findClueForDetailById(String id, ModelAndView modelAndView) {
        //查询数据
        Clue clue = clueService.findClueForDetailById(id);
        List<ClueRemark> clueRemarkList = clueRemarkService.findClueRemarkForDetailByClueId(id);
        List<Activity> activityList = activityService.findActivityByClueId(id);
        //封装参数
        modelAndView.addObject("clue", clue);
        modelAndView.addObject("clueRemarkList", clueRemarkList);
        modelAndView.addObject("activityList", activityList);
        modelAndView.setViewName("workbench/clue/detail");
        return modelAndView;
    }


    /**
     * 分页查询数据
     *
     * @param clue     线索对象
     * @param pageNo   当前页
     * @param pageSize 每页数量
     * @return 结果集
     */
    @RequestMapping("findPagingClue")
    public Object findPagingClue(Clue clue, @RequestParam(defaultValue = "1") Integer pageNo,
                                 @RequestParam(defaultValue = "10") Integer pageSize) {
        Integer beginNo = (pageNo - 1) * pageSize;

        List<Clue> clueList = clueService.findPagingForDetailClue(clue, beginNo, pageSize);
        long totalRows = clueService.findCountPagingClue(clue);
        Map<String, Object> map = new HashMap<>();
        map.put("clueList", clueList);
        map.put("totalRows", totalRows);

        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(map);
        return returnObject;
    }

    /**
     * 根据线索id查询线索
     *
     * @param id 线索id
     * @return 结果集
     */
    @RequestMapping("findClueById")
    public Object findClueById(String id) {
        Clue clue = clueService.findClueById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(clue);
        return returnObject;
    }


    /**
     * 添加线索
     *
     * @param clue 线索对象
     * @return 结果集
     */
    @RequestMapping("addClue")
    public Object addClue(Clue clue) {
        //设置参数
        clue.setId(UUIDUtils.getUUID());
        clue.setCreateTime(DateUtils.formatDateTime(new Date()));
        User user = (User) session.getAttribute(Contents.SESSION_USER);
        clue.setCreateBy(user.getId());

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = clueService.addClue(clue);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("添加失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("添加失败,出现异常");
        }
        return returnObject;
    }


    /**
     * 根据id更新线索
     *
     * @param clue 线索对象
     * @return 结果集
     */
    @RequestMapping("modifyClue")
    public Object modifyClue(Clue clue) {
        //设置参数
        clue.setEditTime(DateUtils.formatDateTime(new Date()));

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = clueService.modifyClueById(clue);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("更新失败");
            }
        } catch (Exception e) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("更新失败,出现异常");
        }
        return returnObject;
    }

    /**
     * 根据多个线索id删除线索
     *
     * @param ids 多个线索id
     * @return 结果集
     */
    @RequestMapping("removeClueByIds")
    public Object removeClueByIds(@RequestParam String[] ids) {
        System.out.println(ids.length);

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = clueService.removeClueByIds(ids);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("删除失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败,出现异常");
        }
        return returnObject;
    }

}
