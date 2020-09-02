package com.jiandanjiuer.crm.web.exception.resolver;

import com.jiandanjiuer.crm.commons.contants.Contents;
import com.jiandanjiuer.crm.commons.domain.ReturnObject;
import com.jiandanjiuer.crm.commons.utils.GetHtmlContentUtils;
import com.jiandanjiuer.crm.settings.web.exception.LoginException;
import com.jiandanjiuer.crm.web.exception.AjaxRequestException;
import com.jiandanjiuer.crm.web.exception.InterceptorException;
import com.jiandanjiuer.crm.web.exception.TraditionRequestException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

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

    @ExceptionHandler(value = InterceptorException.class)
    public String interceptorExceptionResolver(Exception e) {

        System.out.println("处理没登陆");

        e.printStackTrace();

        return "redirect:/settings/user/toLogin.do";

    }

    @ExceptionHandler(value = AjaxRequestException.class)
    public Object ajaxRequestExceptionResolver(Exception e) {
        e.printStackTrace();
        return ReturnObject.getReturnObject(Contents.RETURN_OBJECT_CODE_FAIL, "请求失败");

    }

    @ExceptionHandler(value = TraditionRequestException.class)
    public String traditionRequestExceptionResolver(Exception e) {

        e.printStackTrace();

        return "redirect:/fail.jsp";

    }

    @ExceptionHandler(value = Exception.class)
    public String exceptionResolver(HttpServletRequest request, Exception e) {
        e.printStackTrace();
        String translateResult = "";
        try {
            translateResult = GetHtmlContentUtils.getTranslateResult(e.getMessage());
            request.setAttribute("msgZh", translateResult);
            request.setAttribute("msgEn", e.getMessage());
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return "error";
    }
}





































