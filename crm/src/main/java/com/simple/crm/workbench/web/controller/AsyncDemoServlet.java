package com.simple.crm.workbench.web.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.TimeUnit;

/**
 * @author 简单
 * @date 2020/9/11
 */
@WebServlet(urlPatterns = "/demo", asyncSupported = true)
public class AsyncDemoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //resp.setHeader("Connection", "Keep-Alive");
        resp.setContentType("text/html;charset=utf-8");

        System.out.println(req.isAsyncSupported() + "  " + req.isAsyncStarted());
        /*req.getAsyncContext(); 表示的是最近的那个被request创建或者是
         * 重转发的AsyncContext
         */

        final AsyncContext ac = req.startAsync();
        //设置超时的时间
        ac.setTimeout(5 * 1000L);

        //这种方式
        ac.start(new Runnable() {
            @Override
            public void run() {
                try {

                    System.out.println(1);
                    TimeUnit.SECONDS.sleep(3L);

                    PrintWriter writer = ac.getResponse().getWriter();
                    writer.write("1");
                    writer.flush();
                    System.out.println(2);
                    TimeUnit.SECONDS.sleep(3L);
                    System.out.println(3);
                    //这是测试  同一个AsyncContext在没有调用complete 之前能不能多次的
                    //调用request 和response
                    PrintWriter writer1 = ac.getResponse().getWriter();
                    writer1.write("2");
                    writer1.flush();

                    ServletRequest request = ac.getRequest();

                    request.setAttribute("isAsyn", true);

                    /*
                     * 2.在调用完complete之后 表示这个异步已经结束了 如果在调用
                     * getRequest 或者是getResponse的话 都会抛出IllegalStateException
                     *
                     * */
                    ac.complete();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        //设置监听
        ac.addListener(new AsyncListenerImpl());

        // 在同一个request中不能同时调用多次
        //req.startAsync();
        PrintWriter out = resp.getWriter();
        out.write("返回结果");
        out.write("<br/>");
        //调用flush 不然还是不会输出  因为没有将内容刷出去
        out.flush();
    }

    static class AsyncListenerImpl implements AsyncListener {

        @Override
        public void onComplete(AsyncEvent event) throws IOException {

            System.out.println("执行完毕");
        }

        @Override
        public void onTimeout(AsyncEvent event) throws IOException {
            System.out.println("超过时间");
            event.getAsyncContext().complete();
        }

        @Override
        public void onError(AsyncEvent event) throws IOException {
            System.out.println("出现异常");
        }

        @Override
        public void onStartAsync(AsyncEvent event) throws IOException {
            System.out.println("开始执行");
        }
    }

}
