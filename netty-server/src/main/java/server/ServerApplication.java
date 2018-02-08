package server;

import common.BaseMsg;
import io.netty.channel.socket.SocketChannel;

import java.util.concurrent.TimeUnit;

/**
 * Created by alan.zheng on 2018/2/8.
 */
public class ServerApplication {
    public static void main(String[] args) throws InterruptedException {
        NettyServerBootstrap bootstrap=new NettyServerBootstrap(9999);
        while (true){
            SocketChannel channel=(SocketChannel)NettyChannelMap.get("001");
            if(channel!=null){
                BaseMsg baseMsg=new BaseMsg();
                channel.writeAndFlush(baseMsg);
            }
            TimeUnit.SECONDS.sleep(1000);
        }
    }
}
