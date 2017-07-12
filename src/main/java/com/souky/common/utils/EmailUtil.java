package com.souky.common.utils;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.Version;

/**
 * 
 * 邮件工具类
 * */
public class EmailUtil {

	// 设置服务器
    private static String KEY_SMTP = "mail.smtp.host";
    private static String VALUE_SMTP = "smtp.mxhichina.com";
    // 服务器验证
    private static String KEY_PROPS = "mail.smtp.auth";
    // 发件人用户名、密码
    private static String SEND_USER = "verification@soukys";
    private static String COM = ".com";
    private static String SEND_PWD = "Sjn268450";
    // 建立会话
    private static MimeMessage message;
    private static Session s;
    

    public EmailUtil() {
    }
    
    /**
     * 发送邮件
     * 
     * @param headName 邮件头文件名
     * @param sendHtml 邮件内容
     * @param receiveUser 收件人地址
     * @return boolean
     */
    public static boolean doSendHtmlEmail(String headName, String sendHtml,
            String receiveUser) {
        try {
        	Properties props = System.getProperties();
            props.setProperty(KEY_SMTP, VALUE_SMTP);
            props.put(KEY_PROPS, "true");
            s =  Session.getDefaultInstance(props, new Authenticator(){
                  protected PasswordAuthentication getPasswordAuthentication() {
                      return new PasswordAuthentication(SEND_USER+COM, SEND_PWD);
                  }});
            s.setDebug(true);
            message = new MimeMessage(s);
            // 发件人
            InternetAddress from = new InternetAddress(SEND_USER+COM);
            message.setFrom(from);
            // 收件人
            InternetAddress to = new InternetAddress(receiveUser.trim());
            message.setRecipient(Message.RecipientType.TO, to);
            // 邮件标题
            message.setSubject(headName);
            String content = sendHtml.toString();
            // 邮件内容,也可以使纯文本"text/plain"
            message.setContent(content, "text/html;charset=utf-8");
            message.saveChanges();
            Transport transport = s.getTransport("smtp");
            // smtp验证，就是你用来发邮件的邮箱用户名密码
            transport.connect(VALUE_SMTP, SEND_USER+COM, SEND_PWD);
            // 发送
    		transport.sendMessage(message, message.getAllRecipients());
            transport.close();
            return true;
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 获取模板邮件 有可能返回null
     * */
    public static String getEmailModel(Model model,String templateType,HttpServletRequest request) {
    	Version incompatibleImprovements = new Version("2.3.23");
    	Configuration conf = new Configuration(incompatibleImprovements);
    	conf.setClassForTemplateLoading(EmailUtil.class, "");
    	conf.setDefaultEncoding("utf-8");
    	String text = null;
        try {
        	Template template = conf.getTemplate(templateType+".ftl");
			text = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TemplateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return text;
    }
    
    public static void main(String[] args) {
    	
    	EmailUtil.doSendHtmlEmail("测试邮件","<font style='color:red;font-size:28px;'>啦啦啦啦啦</font>","136069803@qq.com");
	}

}
