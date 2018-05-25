package com.jy.protocol.jf.tcp;

import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import com.jy.protocol.jf.utils.ThreadSwitchUtils;
import com.jy.protocol.jf.utils.TypeConversionUtils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.LinkedList;

public class TcpUtil {

    private static Socket socket = null;

    /**
     * 发送tcp
     *
     * @param ip   需要发送的ip的地址
     * @param code 发送的内容
     * @param port 端口号
     */
    public static void sendTcp(String ip, String code, int port) {

        Socket socket = null;
        OutputStream outputStream = null;
        InputStream inputStream = null;

        try {
            //创建Socket对象
            socket = new Socket(ip, port);

            //根据输入输出流和服务端连接
            //获取一个输出流，向服务端发送信息
            outputStream = socket.getOutputStream();
            //将输出流包装成打印流
            outputStream.write(TypeConversionUtils.hexStringToBytes(code));

        } catch (UnknownHostException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
                if (socket != null) {
                    socket.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

    /**
     * 发送tcp
     *
     * @param ip   需要发送的ip的地址
     * @param code 发送的内容
     * @param port 端口号
     */
    public static void registerTcp(String ip, String code, int port) {

        //Socket socket = null;
        OutputStream outputStream = null;
        InputStream inputStream = null;

        try {
            //创建Socket对象
            socket = new Socket(ip, port);
            socket.setKeepAlive(true);

            //根据输入输出流和服务端连接
            //获取一个输出流，向服务端发送信息
            outputStream = socket.getOutputStream();
            //将输出流包装成打印流
            outputStream.write(TypeConversionUtils.hexStringToBytes(code));
            //关闭输出流
            //socket.shutdownOutput();
            //获取一个输入流，接收服务端的信息
            inputStream = socket.getInputStream();
            System.out.println("平台开始连接-------------------------");
            LinkedList<String> returnStringList = new LinkedList<>();
            while (true) {
                if (!socket.isConnected()) {
                    System.out.println("----未知原因,断开连接,disconnect...");
                    ThreadSwitchUtils.closeServerThread();
                }
                int count = 0;
                while (count == 0) {
                    count = inputStream.available();
                }
                byte[] b = new byte[count];
                inputStream.read(b);
                String codeReturn = TypeConversionUtils.bytesToHexString(b).replaceAll(" ", "");


                if (codeReturn.length() > 22) {
                    returnStringList.add(codeReturn);
                } else {
                    if (returnStringList.size() != 0) {
                        IssuedSendUtils.reductionFileUpload(returnStringList);
                    }
                    returnStringList.clear();
                }

                String codes = codeReturn.substring(14, 16);
                if (IssuedSendUtils.HEART_CODE.equals(codes)) {
                    ParamStatic.issuedStaticMap.put(IssuedSendUtils.HEART_BREATH, true);
                    ParamStatic.issuedStaticMap.put("heart_breath_time", new Date());
                }
            }

        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            //断开tcp连接
            System.out.println("----未知原因,断开连接,disconnect...");
            ThreadSwitchUtils.closeServerThread();
            e.printStackTrace();
        } finally {

        }
    }


    public static void shutdownTcp() {
        if (socket != null) {
            try {
                socket.close();
                ParamStatic.issuedStaticMap.put(IssuedSendUtils.HEART_BREATH, false);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
