import com.jy.protocol.jf.utils.IssuedSendUtils;

//协议测试类
public class IssTest {
	
	public static final String ip = "192.168.1.251";
	
	public static void main(String[] args) {
		lianjiepingtaiceshi();
		//TcpUtil.receiveTcpThread(6600, "asdasd");
		//TcpUtil.receiveTcp(6600, "asdasd");
	}
	
	public static void lianjiepingtaiceshi() {
		IssuedSendUtils.registerPlatform(1, ip, IssuedSendUtils.TCP_PORT);
	}
	
	
}
