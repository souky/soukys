package com.jy.protocol.jf.utils;


import com.jy.protocol.common.listener.IssuedListener;
import com.jy.protocol.jf.tcp.TcpUtil;
import com.jy.protocol.jf.thread.RegisterThread;

/**
 * @author wb
 * 开关线程
 */
public class ThreadSwitchUtils {
	
	/**
	 * 关闭服务的线程
	 */
	public static void closeServerThread() {
		ThreadGroup group = Thread.currentThread().getThreadGroup();
		int threads = group.activeCount();
		Thread[] lstThreads = new Thread[threads];
		group.enumerate(lstThreads);
		for(Thread thread : lstThreads) {
            //断开注册tcp协议
            if(IssuedListener.REGISTER.equals(thread.getName())) {
                ((RegisterThread)thread).setFlag(false);
                TcpUtil.shutdownTcp();
                thread = null;
            }
        }
        //ParamStatic.issuedStaticMap.put("flag", false);
	}
	
	/**
	 * 开启服务的线程
	 */
	public static void startServerThread() {

		ThreadGroup group = Thread.currentThread().getThreadGroup();
		int threads = group.activeCount();
		Thread[] lstThreads = new Thread[threads];
		group.enumerate(lstThreads);
		boolean flagReg = false;

		for(Thread thread : lstThreads){
			if(IssuedListener.REGISTER.equals(thread.getName())) {
				//ParamStatic.issuedStaticMap.put("flag", true);
                ((RegisterThread)thread).setFlag(true);
                thread.start();
				flagReg = true;
			}
		}
		if(!flagReg){
            RegisterThread registerThread = new RegisterThread(IssuedListener.REGISTER);
            //ParamStatic.issuedStaticMap.put("flag", true);
            //registerThread.setFlag(true);
            registerThread.start();
        }
	}

}
