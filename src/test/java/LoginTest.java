import com.jy.common.entity.RequestMsg;
import com.jy.common.utils.UnitTestUtils;
import org.junit.Test;

/**
 * Created by wb on 2017/12/10 15:06
 */
public class LoginTest {

    @Test
    public void loginTest(){

        RequestMsg msg = new RequestMsg();
        msg.setMethod("login");
        msg.getParams().put("username", "goldsun");
        msg.getParams().put("password", 123456);


        String res = UnitTestUtils.doPost(msg);
        System.out.println(res);
    }
}
