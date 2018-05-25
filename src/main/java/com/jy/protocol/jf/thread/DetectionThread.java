package com.jy.protocol.jf.thread;


import com.jy.protocol.jf.udp.UdpUtil;
import com.jy.protocol.jf.utils.IssuedSendUtils;

public class DetectionThread implements Runnable{

	@Override
	public void run() {
		//接收侦测UDP
    	UdpUtil.receiveUdp(IssuedSendUtils.DETECTION_UDP_PORT);
	}

		
}
