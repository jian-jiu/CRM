package com.jiandanjiuer.crm.web.exception.resolver;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.GetHtmlContentUtils;
import com.jiandanjiuer.crm.settings.web.exception.LoginException;
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
        e.printStackTrace();
        //返回登入失败信息
        return ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, e.getMessage());
    }

    @ExceptionHandler(value = Exception.class)
    public String exceptionResolver(HttpServletRequest request, HttpServletResponse response, Exception e) {
        e.printStackTrace();
        String translateResult = "";
        try {
            //翻译功能
            translateResult = GetHtmlContentUtils.getTranslateResult(e.getMessage());
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        //判断是否是ajax请求
        if (request.getHeader("X-Requested-With") != null) {
            Object returnObject = ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, translateResult);
            try {
                ObjectMapper objectMapper = new ObjectMapper();
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





































