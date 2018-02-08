package client;

import common.BaseMsg;
import common.MsgType;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.util.ReferenceCountUtil;

/**
 * Created by alan.zheng on 2018/2/8.
 */
public class NettyClientHandler extends SimpleChannelInboundHandler<BaseMsg> {
    /**
     * 心跳发送
     * @param ctx
     * @param evt
     * @throws Exception
     */
//    @Override
//    public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
//        super.userEventTriggered(ctx, evt);
//    }

    /**
     * 客户端获取响应
     * @param channelHandlerContext
     * @param baseMsg
     * @throws Exception
     */
    @Override
    protected void channelRead0(ChannelHandlerContext channelHandlerContext, BaseMsg baseMsg) throws Exception {
        MsgType msgType=baseMsg.getType();
        switch (msgType){
            case PING:{
                System.out.println("receive ping from server----------");
            }break;
            case ASK:{
                channelHandlerContext.writeAndFlush(baseMsg.getMsgBody());
                System.out.print("客户端接受信息" + baseMsg.getMsgBody());
            }break;
            case REPLY:{
                System.out.println("客户端接受信息并回复信息: "+baseMsg.getMsgBody());
            }
            default:break;
        }
        ReferenceCountUtil.release(msgType);
    }
}
