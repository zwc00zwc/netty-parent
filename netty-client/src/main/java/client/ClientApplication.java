package client;

import common.BaseMsg;
import common.Constants;
import common.MsgType;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Created by alan.zheng on 2018/2/8.
 */
public class ClientApplication {
    public static void main(String[] args) throws InterruptedException {
        Constants.setClientId("001");
        NettyClientBootstrap bootstrap=new NettyClientBootstrap(9999,"localhost");
        while (true){
            TimeUnit.SECONDS.sleep(3);
            BaseMsg baseMsg=new BaseMsg();
            baseMsg.setType(MsgType.ASK);
            baseMsg.setMsgBody(new Date().toString());
            bootstrap.getSocketChannel().writeAndFlush(baseMsg);
        }
    }
}
