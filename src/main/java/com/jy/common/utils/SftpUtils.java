package com.jy.common.utils;

import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.util.Properties;  
import java.util.Vector;  

import org.apache.commons.lang3.StringUtils;  

import com.jcraft.jsch.Channel;  
import com.jcraft.jsch.ChannelSftp;  
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.JSch;  
import com.jcraft.jsch.Session;  
import com.jcraft.jsch.SftpException;  
  
/** 
 * sftp工具类 
 *  
 * @author wb 
 * 
 */  
public class SftpUtils {  
  
  
    /** 
     * 默认连接sftp服务器 
     *  
     * @return ChannelSftp 
     */  
    public static ChannelSftp connect() {  
        Properties pro = new Properties();
		FileInputStream in = null;
    	String path = SftpUtils.class.getClassLoader().getResource("sftp.properties").getPath();
		//绝对路径空格解析
		path = path.replaceAll("%20"," ");
		try {
			in = new FileInputStream(path);
			pro.load(in);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
    	String host = pro.getProperty("ip");
    	int port = 22;
    	String portStr = pro.getProperty("port");
    	try{
    		port = Integer.valueOf(portStr);
    	}catch(NumberFormatException e){
    		e.printStackTrace();
    	}
    	String username = pro.getProperty("username");
    	String password = pro.getProperty("password");
        return connect(host, port, username, password);  
    }  
  
    /** 
     * 连接sftp服务器 
     * @param host 主机 
     * @param port 端口 
     * @param username 用户名 
     * @param password 密码 
     * @return sftp
     */  
    public static ChannelSftp connect(String host, int port, String username,String password) {  
    	System.out.println("sftp 开始连接 ################");
        ChannelSftp sftp = null;  
        try {  
            JSch jsch = new JSch();  
            jsch.getSession(username, host, port);  
            Session sshSession = jsch.getSession(username, host, port);  
            sshSession.setPassword(password);  
            Properties sshConfig = new Properties();  
            sshConfig.put("StrictHostKeyChecking", "no");  
            sshSession.setConfig(sshConfig);  
            sshSession.connect();  
            Channel channel = sshSession.openChannel("sftp");  
            channel.connect();  
            sftp = (ChannelSftp) channel;  
            System.out.println("Connected to " + host + ":" + port + ".........");  
            System.out.println("sftp 连接成功");
        } catch (Exception e) { 
        	System.out.println("sftp connect failed...................");
            e.printStackTrace();
            throw new RuntimeException(e);  
        }  
        return sftp;  
    }  
    
    /**
     * 断开连接
     */
    public static void disConnect(ChannelSftp sftp){
    	if(sftp != null){
    		sftp.disconnect();
    		System.out.println("###  disconnect sftp");
    	}
    }
  
    /** 
     * 上传文件 
     * @param directory 上传的目录
     * @param uploadFile 要上传的文件 
     * @param sftp 
     */  
    public static void upload(String directory, String uploadFile,ChannelSftp sftp) {  
            //mkDir(directory, sftp);  
            InputStream in = null;  
            try {  
                sftp.cd(directory);  
                File file = new File(uploadFile);  
                in  = new FileInputStream(file);  
                sftp.put(new FileInputStream(file), file.getName());  
            } catch (Exception e) {  
                e.printStackTrace();  
            } finally{  
                try {  
                    in.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
    }  
  
    /** 
     * 下载文件 
     * @param directory 下载文件所在目录 
     * @param downloadFile 下载的文件 
     * @param saveFile 存在本地的路径 
     * @param sftp 
     */  
    public static void download(String directory, String downloadFile,  
            String saveFile, ChannelSftp sftp) {  
        try {  
            sftp.cd(directory);  
            File file = new File(saveFile);  
            sftp.get(downloadFile, new FileOutputStream(file));  
        } catch (Exception e) {  
            e.printStackTrace();  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * 删除文件 
     * @param directory 要删除文件所在目录 
     * @param deleteFile 要删除的文件 
     * @param sftp 
     */  
    public static void delete(String directory, String deleteFile,  
            ChannelSftp sftp) {  
        try {  
            sftp.cd(directory);  
            sftp.rm(deleteFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * 列出目录下的文件 
     * @param directory 要列出的目录 
     * @param sftp 
     * @return 
     * @throws SftpException 
     */  
    @SuppressWarnings("unchecked")
	public static Vector<LsEntry> listFiles(String directory, ChannelSftp sftp)  
            throws SftpException {  
        return sftp.ls(directory);  
    }  
      
     /**  
     * 打开指定目录  
     * @param directory directory  
     * @return 是否打开目录  
     */   
    public static boolean openDir(String directory,ChannelSftp sftp){   
        try{   
            sftp.cd(directory);   
            return true;   
        }catch (SftpException e){   
            return false;   
        }   
    }   
      
    /**  
     * 创建指定文件夹  
     * @param dirName  
     */   
    public static void mkDir(String dirName,ChannelSftp sftp){   
        String[] dirs = dirName.split("/");   
          
        try{   
            String now = sftp.pwd();   
            sftp.cd("/");  
            for (int i = 0; i < dirs.length; i++){   
                if (StringUtils.isNotEmpty(dirs[i])) {  
                     boolean dirExists = openDir(dirs[i],sftp);   
                     if(!dirExists){   
                         sftp.mkdir(dirs[i]);   
                         sftp.cd(dirs[i]);   
                     }   
                }  
            }   
            sftp.cd(now);   
        }   
        catch (SftpException e){   
            e.printStackTrace();  
        }   
    }   
  
}  
