package com.asy.test.websocket.jsp;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;

/**
 * Created by asy
 */


@ServerEndpoint("/webs/channel")
public class WebSocketHandler {


    @OnOpen
    public void onOpen(Session websocketSession) throws IOException {
        System.out.println("New websocket connection established : " + websocketSession.getId());
        websocketSession.getBasicRemote().sendText("Hello from server");
    }


    @OnMessage
    public void onMessage(Session websocketSession, String message) throws IOException {
        System.out.println("Websocket message received from : " + websocketSession.getId());

        for(int i = 0; i< 5; i++) {
            websocketSession.getBasicRemote().sendText(message);
        }

    }

    @OnError
    public void onError(Session websocketSession, Throwable throwable) {
        System.out.println("Error occurred for websocket session : " + websocketSession.getId());
        throwable.printStackTrace();
    }


    @OnClose
    public void onClose(Session websocketSession, CloseReason closeReason) {
        System.out.println("Websocket session closed : " + websocketSession.getId());
    }


}
