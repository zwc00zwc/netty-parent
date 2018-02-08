import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.HandlerList;
import server.HomeController;
import server.IndexController;

/**
 * Created by alan.zheng on 2018/1/25.
 */
public class ServerApplication {
    public static void main(String[] args) throws Exception {
        Server server = new Server(8081);
        HandlerList handlerList = new HandlerList();
        handlerList.addHandler(new HomeController());
        handlerList.addHandler(new IndexController());
        //server.setHandler(new HomeController());
        server.setHandler(handlerList);
        server.start();
        server.join();
    }
}
