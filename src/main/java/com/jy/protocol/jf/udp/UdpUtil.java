package com.jy.protocol.jf.udp;


import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import com.jy.protocol.jf.utils.TypeConversionUtils;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class UdpUtil {

	private static DatagramSocket sheildSocket = null;

	private static DatagramSocket detecSocket = null;


	/**
	 * 发送udp协议
	 * @param ip ip地址
	 * @param port 端口号
	 * @param data  发送数据
	 * */
	public static void sendUdp(String ip,int port,byte[] data) {
		
		try {
			//定义服务器的地址，端口号，数据
	        InetAddress address = InetAddress.getByName(ip);
	        //创建数据报
	        DatagramPacket packet = new DatagramPacket(data, data.length, address, port);
	        //创建DatagramSocket，实现数据发送和接收
	        DatagramSocket socket;
	        
			socket = new DatagramSocket();
			//向服务器端发送数据报
	        socket.send(packet);
	        
	        //接收服务器响应数据
//	        byte[] data2 = new byte[1024];
//	        DatagramPacket packet2 = new DatagramPacket(data2, data2.length);
//	        socket.receive(packet2);
//	        String info = new String(data2, 0, packet2.getLength());
//	        System.out.println("我是客户端，服务器说："+info);
	        socket.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
	
	/**
	 * 接收udp协议
	 * @param port 端口号
	 * */
	public static void receiveUdp(int port) {
		try {
			if(IssuedSendUtils.SHIELD_UDP_PORT.equals(port)){
				sheildSocket = new DatagramSocket(port);
				receiveUdp2(sheildSocket,port);
			}
			if(IssuedSendUtils.DETECTION_UDP_PORT.equals(port)) {
				detecSocket = new DatagramSocket(port);
				receiveUdp2(detecSocket,port);
			}
		}catch(IOException e) {
			e.getStackTrace();
		}
	}

	private static void receiveUdp2(DatagramSocket socket, int port){
		try {
			DatagramPacket packet = null;
			byte[] data = null;
			System.out.println("***服务器端启动，等待发送数据***");
			while(true){
				data = new byte[40];//创建字节数组，指定接收的数据包的大小
				packet = new DatagramPacket(data, data.length);
				socket.receive(packet);//此方法在接收到数据报之前会一直阻塞
				String info = null;
				info = TypeConversionUtils.bytesToHexString(packet.getData());

				//处理接受信息
				info = info.replaceAll(" ","");
				String codes = info.substring(14, 16);
				if(IssuedSendUtils.SOURCE.equals(codes)) {
					//屏蔽设备信息
					if(IssuedSendUtils.SHIELD_UDP_PORT.equals(port)){
						String ip = packet.getAddress().getHostAddress();
						IssuedSendUtils.shieldDeviceWithCode(info,ip);

					}
					//侦测设备信息
					if(IssuedSendUtils.DETECTION_UDP_PORT.equals(port)) {
						String ip = packet.getAddress().getHostAddress();
						IssuedSendUtils.detectionDeviceWithCode(info,ip);
					}
				}
			}
		}catch(IOException e) {
			e.getStackTrace();
		}
	}


	public static void shutdownUdp(){
		if(sheildSocket != null){
			sheildSocket.close();
            ParamStatic.issuedStaticMap.put(IssuedSendUtils.SHIELD_IP, null);
		}
		if(detecSocket != null){
			detecSocket.close();
            ParamStatic.issuedStaticMap.put(IssuedSendUtils.DETECTION_IP, null);
		}
	}
}
