package com.jy.protocol.jf.thread;


import com.jy.protocol.common.constant.ParamStatic;
import com.jy.protocol.common.utils.GeneralProtocol;
import com.jy.protocol.jf.utils.IssuedSendUtils;
import org.apache.commons.lang3.StringUtils;


public class RegisterThread extends Thread{

    private volatile boolean flag = true;

    public RegisterThread(){

    }

    public RegisterThread(String name){
        super.setName(name);
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    @Override
    public void run(){
        while(flag){
            String ip = null;
            try {
                ip = (String) ParamStatic.issuedStaticMap.get(IssuedSendUtils.DETECTION_IP);
                Thread.sleep(1000);
                if(StringUtils.isBlank(ip)){
                    System.out.println("未获取到ip信息");
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if(StringUtils.isNotBlank(ip)) {
                GeneralProtocol.register();
                break;
            }
        }
    }
}
