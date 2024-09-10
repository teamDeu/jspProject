package main;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/chat")
public class ChatServer {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        System.out.println("클라이언트가 연결되었습니다: " + session.getId());
    }
    
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("받은 메시지: " + message);
        // 모든 클라이언트에게 메시지 전송
        synchronized (clients) {
            for (Session client : clients) {
                client.getBasicRemote().sendText(message);
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("클라이언트 연결이 종료되었습니다: " + session.getId());
    }
}