package com.simple.crm.web.listener;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import com.simple.crm.settings.service.dictype.DicTypeService;
import com.simple.crm.settings.service.user.UserService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Objects;

/**
 * @author 简单
 * @date 2020/8/19
 */
@WebListener
public class MyContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("ServletContext准备启动");

        ServletContext servletContext = sce.getServletContext();
        WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
        System.out.println("开始读取复选框数据");
        //设置复选框的值
        DicTypeService dicTypeService = Objects.requireNonNull(context).getBean(DicTypeService.class);
        dicTypeService.setAllDicTypeAndDicValueToServletContext(servletContext);
        //设置用户
        UserService userService = Objects.requireNonNull(context).getBean(UserService.class);
        servletContext.setAttribute("userList",userService.queryAllUsers());
        System.out.println("读取复选框数据完毕");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("ServletContext准备注销");
        try {
            while (DriverManager.getDrivers().hasMoreElements()) {
                DriverManager.deregisterDriver(DriverManager.getDrivers().nextElement());
            }
            System.out.println("jdbc驱动程序关闭");
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("清除线程成功");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
