package com.jiandanjiuer.crm.settings.web.exception.resolver;

import com.jiandanjiuer.crm.settings.web.exception.AjaxRequestException;
import com.jiandanjiuer.crm.settings.web.exception.InterceptorException;
import com.jiandanjiuer.crm.settings.web.exception.LoginException;
import com.jiandanjiuer.crm.settings.web.exception.TraditionRequestException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 24245
 */
@ControllerAdvice
public class MyExceptionResolver {

    @ExceptionHandler(value= LoginException.class)
    @ResponseBody
    public Object loginExceptionResolver(Exception e){

        e.printStackTrace();

        Map<String,Object> map = new HashMap<>();
        map.put("success",false);
        map.put("msg",e.getMessage());

        return map;

    }

    @ExceptionHandler(value= InterceptorException.class)
    public String interceptorExceptionResolver(Exception e){

        System.out.println("处理没登陆");

        e.printStackTrace();

        return "redirect:/settings/user/toLogin.do";

    }

    @ExceptionHandler(value= AjaxRequestException.class)
    @ResponseBody
    public Object ajaxRequestExceptionResolver(Exception e){

        e.printStackTrace();

        System.out.println("---------------------====================================");

        Map<String,Object> map = new HashMap<>();
        map.put("success",false);

        return map;

    }
    @ExceptionHandler(value= TraditionRequestException.class)
    public String traditionRequestExceptionResolver(Exception e){

        e.printStackTrace();

        return "redirect:/fail.jsp";

    }

    @ExceptionHandler(value= Exception.class)
    public String exceptionResolver(Exception e){

        e.printStackTrace();

        return "redirect:/fail.jsp";

    }
}





































