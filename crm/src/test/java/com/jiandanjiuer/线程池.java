package com.jiandanjiuer;

import java.util.concurrent.*;

/**
 * @author 简单
 * @date 2020/9/21
 */
public class 线程池 {
    public static void main(String[] args) {
        ExecutorService executorService = new ThreadPoolExecutor(5000, 10000, 1L, TimeUnit.SECONDS, new ArrayBlockingQueue<>(2), Executors.defaultThreadFactory(),new ThreadPoolExecutor.AbortPolicy());
        for (int i = 0; i < 12000; i++) {
            executorService.execute(() -> {
                String name = Thread.currentThread().getName();
                System.out.println(name + " 窗口办理业务中");
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                System.out.println(name + " 窗口业务办理完毕");
            });
        }
        executorService.shutdown();
    }
}
