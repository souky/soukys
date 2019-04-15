package test;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.lang3.StringUtils;

public class TestUserImg {

	
	
	
	
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws Exception {
		
		String url = "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKSUBfgJTh65fVLmCI9fGKe3Mp3fdk6lXvVrXribibk9IR7Ax41UO6lAAvOVt7VcDva6kztzCCY81Ug/132";
		
		String s = getimg(url);
		
		System.out.println(s);
		
	}
	
	
	@SuppressWarnings("resource")
	public static String getimg(String aurl) throws Exception{
		String url = "";
		if(StringUtils.isBlank(aurl)) {
			return aurl;
		}
		HttpURLConnection conn = (HttpURLConnection) new URL(aurl)
                .openConnection();
        conn.setReadTimeout(5000);
        conn.setConnectTimeout(5000);
        conn.setRequestMethod("GET");

        if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
            InputStream inputStream = conn.getInputStream();
            BufferedInputStream bis = new BufferedInputStream(inputStream);
            File file = new File("E:/punchImg/a.jpg");
            BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file));
	        byte[] buffer = new byte[1024];
	        int len = -1;
	        while ((len = bis.read(buffer)) != -1) {
	            bos.write(buffer, 0, len);
	            bos.flush();
	        }
        }
		return url;
	}
}
