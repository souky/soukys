package com.jy.protocol.jf.thread;


import com.jy.protocol.jf.udp.UdpUtil;
import com.jy.protocol.jf.utils.IssuedSendUtils;

public class ShieldThread  implements Runnable{

	@Override
	public void run() {
		//接收屏蔽UDP
    	UdpUtil.receiveUdp(IssuedSendUtils.SHIELD_UDP_PORT);
	}

		
}
