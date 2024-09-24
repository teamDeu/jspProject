package main;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/chat")
public class ChatServer {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static HashMap<String,String> userCharacter = new HashMap<String,String>();
    private static HashMap<String,String> userId = new HashMap<String,String>();
    private static HashMap<String,String> userUrl = new HashMap<String,String>();
    private static HashMap<String,String> userName = new HashMap<String,String>();
    @OnOpen
    
    
    public void onOpen(Session session) {
        clients.add(session);
        
        System.out.println("클라이언트가 연결되었습니다: " + session.getId());
    }
    
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("받은 메시지: " + message);
        // 모든 클라이언트에게 메시지 전송
        String[] rawData = message.split(";");
        String command = rawData[0];
        String data = rawData[1];
        if(command.equals("connect")) {
        	String url = rawData[3];
        	String name = rawData[4];
        	userUrl.put(session.getId(),url);
        	userId.put(session.getId(),data);
        	userCharacter.put(data, rawData[2]);
        	userName.put(session.getId(), name);
        	synchronized (clients) {
                for (int i = 0; i < clients.size() ; i++) {
                	Session client = (Session)clients.toArray()[i];
                	try {
                		String userIdValue = userId.get(client.getId());
                		String userCharacterValue = userCharacter.get(userIdValue);
                		String userNameValue = userName.get(client.getId());
                		if(session.getId() == client.getId()) {
                			continue;
                		}
                		System.out.println("접속된사람의 URL : " + userUrl.get(client.getId()));
                		System.out.println("방금접속한 사람의 URL : "  + userUrl.get(session.getId()));
                		if(userUrl.get(client.getId()).equals(userUrl.get(session.getId()))){
                			session.getBasicRemote().sendText("init;" +userIdValue +";" + userCharacterValue +";" +userNameValue);
                		}
                		
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
                    
                }
            }
        }
    	synchronized (clients) {
            for (Session client : clients) {
            	if(userUrl.get(client.getId()).equals(userUrl.get(session.getId()))){
            		client.getBasicRemote().sendText(message);
        		}
            }
        }
        
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("클라이언트 연결이 종료되었습니다: " + session.getId());
    }
}