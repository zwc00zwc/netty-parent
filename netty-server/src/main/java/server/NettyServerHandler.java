package server;

import common.BaseMsg;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.socket.SocketChannel;
import io.netty.util.ReferenceCountUtil;

/**
 * Created by alan.zheng on 2018/2/8.
 */
public class NettyServerHandler extends SimpleChannelInboundHandler<BaseMsg> {
    @Override
    public void channelInactive(ChannelHandlerContext ctx) throws Exception {
        NettyChannelMap.remove((SocketChannel) ctx.channel());
    }

    @Override
    protected void channelRead0(ChannelHandlerContext channelHandlerContext, BaseMsg baseMsg) throws Exception {
        NettyChannelMap.add(baseMsg.getClientId(),(SocketChannel)channelHandlerContext.channel());
        switch (baseMsg.getType()){
            case PING:{
                NettyChannelMap.get(baseMsg.getClientId()).writeAndFlush(baseMsg.getMsgBody());
            }break;
            case ASK:{
                //收到客户端的请求
//                if("authToken".equals(baseMsg.getParams().getAuth())){
                    NettyChannelMap.get(baseMsg.getClientId()).writeAndFlush(baseMsg);
                    System.out.println("服务端接受客户端发送的信息: "+baseMsg.getMsgBody());
//                }
            }break;
            case REPLY:{
                //收到客户端回复
                System.out.println("服务端接受客户端信息: "+baseMsg.getMsgBody());
            }break;
            default:break;
        }
        ReferenceCountUtil.release(baseMsg);
    }
}
