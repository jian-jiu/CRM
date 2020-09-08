package com.simple.crm.web.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.simple.crm.commons.contants.Contents;
import com.simple.crm.commons.domain.ReturnObject;
import com.simple.crm.commons.utils.webutil.BaiduTranslatorUtils;
import com.simple.crm.settings.web.exception.LoginException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 对controller进行增强，统一的异常处理
 *
 * @author 24245
 */
@ControllerAdvice
public class MyExceptionResolver {

    /**
     * 指定方法处理什么异常
     */
    @ExceptionHandler(value = LoginException.class)
    @ResponseBody
    public Object loginExceptionResolver(Exception e) {
        ReturnObject returnObject = new ReturnObject();
        e.printStackTrace();
        //返回登入失败信息
        returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
        returnObject.setMessage(e.getMessage());
        return returnObject;
    }

    @ExceptionHandler(value = Exception.class)
    public String exceptionResolver(HttpServletRequest request, HttpServletResponse response, Exception e) {
        e.printStackTrace();
        String translateResult = "";
        try {
            //翻译功能
            translateResult = BaiduTranslatorUtils.getTranslateResult(e.getMessage());
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        //判断是否是ajax请求
        if (request.getHeader("X-Requested-With") != null) {
            ReturnObject returnObject = new ReturnObject();
            returnObject.setCode(Contents.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage(translateResult);
            ObjectMapper objectMapper = new ObjectMapper();
            try {
                String s = objectMapper.writeValueAsString(returnObject);
                response.getWriter().write(s);
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
            return null;
        }
        //转发到失败界面
        request.setAttribute("msgZh", translateResult);
        request.setAttribute("msgEn", e.getMessage());
        return "error";
    }
}





































