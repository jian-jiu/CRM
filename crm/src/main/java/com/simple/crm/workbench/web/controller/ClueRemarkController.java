package com.simple.crm.workbench.web.controller;

import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.otherutil.DateUtils;
import com.simple.crm.commons.utils.otherutil.UUIDUtils;
import com.simple.crm.settings.domain.User;
import com.simple.crm.workbench.domain.clue.ClueRemark;
import com.simple.crm.workbench.service.clue.ClueRemarkService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @author 简单
 * @date 2020/9/8
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/workbench/clue/")
public class ClueRemarkController {

    private final ClueRemarkService clueRemarkService;

    private final HttpSession session;

    /**
     * 根据id查询详细的线索备注
     *
     * @param id id
     * @return 结果集
     */
    @RequestMapping("findClueRemarkById")
    public Object findClueRemarkById(String id) {
        ClueRemark clueRemark = clueRemarkService.findClueRemarkForDetailById(id);
        ReturnObject returnObject = new ReturnObject();
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        returnObject.setData(clueRemark);
        return returnObject;
    }

    /**
     * 添加一条线索备注
     *
     * @param clueRemark 线索备注对象
     * @return 结果集
     */
    @RequestMapping("addClueRemark")
    public Object addClueRemark(ClueRemark clueRemark) {
        //设置添加线索默认参数
        clueRemark.setId(UUIDUtils.getUUID());
        clueRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        if (clueRemark.getCreateBy() == null || "".equals(clueRemark.getCreateBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            clueRemark.setCreateBy(user.getId());
        }
        clueRemark.setEditFlag("0");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = clueRemarkService.addClueRemark(clueRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
                clueRemark = clueRemarkService.findClueRemarkForDetailById(clueRemark.getId());
                returnObject.setData(clueRemark);
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

    @RequestMapping("modifyClueRemark")
    public Object modifyClueRemark(ClueRemark clueRemark) {
        clueRemark.setEditTime(DateUtils.formatDateTime(new Date()));
        if (clueRemark.getEditBy() == null || "".equals(clueRemark.getEditBy())) {
            User user = (User) session.getAttribute(Contents.SESSION_USER);
            clueRemark.setEditBy(user.getId());
        }
        clueRemark.setEditFlag("1");

        ReturnObject returnObject = new ReturnObject();
        try {
            int i = clueRemarkService.modifyClueRemark(clueRemark);
            if (i > 0) {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);

            } else {
                returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("修改失败,出现异常");
        }
        return returnObject;
    }

    /**
     * 根据id删除线索备注
     *
     * @param id id
     * @return 删除条数
     */
    @RequestMapping("removeClueRemarkById")
    public Object removeClueRemarkById(String id) {
        ReturnObject returnObject = new ReturnObject();
        int i = clueRemarkService.removeClueRemarkById(id);
        if (i > 0) {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_SUCCESS);
        } else {
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("删除失败");
        }
        return returnObject;
    }
}
