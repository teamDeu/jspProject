package main;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import report.ChatLogBean;
import report.ReportMgr;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.Vector;

@ServerEndpoint("/chaasdft")
public class ChatServer {
	
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static HashMap<String,Integer> urlCount = new HashMap<String,Integer>();
    private static HashMap<String,String> refuseId = new HashMap<String,String>();
    private static HashMap<String,User> userInfo = new HashMap<String,User>();
    private static String dataSeparator = "㉠";
    boolean flag;
    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        
        System.out.println("클라이언트가 연결되었습니다: " + session.getId());
    }
    
    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
    	flag = true;
        System.out.println("받은 메시지: " + message);
        // 모든 클라이언트에게 메시지 전송
        String[] rawData = message.split(dataSeparator);
        String command = rawData[0];
        String data = rawData[1];
        if(command.equals("connect")) {
        	String url = rawData[3];
        	String name = rawData[4];
        	userInfo.put(session.getId(),new User(session, data, url, name, rawData[2]));
        	if(urlCount.get(url) != null) {
        		if(urlCount.get(url) == 8) {
        			System.out.println(urlCount.get(url)+"접속거부됨");
        			refuseId.put(session.getId(),url);
        			session.getBasicRemote().sendText("refuse");
            		return;
        		}
        		else {
        			urlCount.put(url,urlCount.get(url)+1);
        			System.out.println(urlCount.get(url) + "접속됨");
        		}
        	}
        	else {
        		urlCount.put(url, 1);
        	}
        	
        	
        	

        	synchronized (clients) {
                for (int i = 0; i < clients.size() ; i++) {
                	Session client = (Session)clients.toArray()[i];
                	try {
                		User user = userInfo.get(client.getId());
                		String userIdValue = user.getUserId();
                		String userCharacterValue = user.getUserCharacter();
                		String userNameValue = user.getUserName();
                		String userUrl = user.getConnectedUrl();
                		
                		User connectUser = userInfo.get(session.getId());
                		if(session.getId() == client.getId()) {
                			continue;
                		}
                		if(userUrl.equals(connectUser.getConnectedUrl())){
                			session.getBasicRemote().sendText("init"+ dataSeparator +userIdValue + dataSeparator + userCharacterValue +dataSeparator +userNameValue);
                		}
                		
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
                    
                }
            }
        }
        else if(command.equals("sendFriendRequest")) {
        	synchronized (clients) {
                for (Session client : clients) {
                		client.getBasicRemote().sendText(message);	
                }
            }
        	flag = false;
        }
        else if(command.equals("submitFriendRequest")) {
        	synchronized (clients) {
                for (Session client : clients) {
                		client.getBasicRemote().sendText(message);	
                }
            }
        	flag = false;
        }
        else if(command.equals("sendMessage")) {
        	String id = data.split("㉡")[0];
        	String comment = data.split("㉡")[1];
        	ReportMgr mgr = new ReportMgr();
        	ChatLogBean bean = new ChatLogBean();
        	bean.setChatlog_id(id);
        	bean.setChatlog_content(comment);
        	mgr.insertChatLog(bean);
        }
        else if(command.equals("sendAlarm")) {
        	String id = data;
        	synchronized (clients) {
                for (Session client : clients) {
                	User user = userInfo.get(client.getId());
            		String userIdValue = user.getUserId();
            		
            		User connectUser = userInfo.get(session.getId());
                		if(userIdValue.equals(data)) {
                			client.getBasicRemote().sendText(message);	
                		}
                }
            }
        	flag = false;
        }
        if(flag) {
        	synchronized (clients) {
                for (Session client : clients) {
                	User user = userInfo.get(client.getId());
            		String userIdValue = user.getUserId();
            		String userUrl = user.getConnectedUrl();
            		
            		User connectUser = userInfo.get(session.getId());
            		String sendUserUrl = connectUser.getConnectedUrl();
                	if(userUrl.equals(sendUserUrl)){
                		client.getBasicRemote().sendText(message);
            		}
                }
            }
        }
    	
        
    }

    @OnClose
    public void onClose(Session session) {
    	User connectUser = userInfo.get(session.getId());
		String userUrl = connectUser.getConnectedUrl();
    	if(refuseId.get(session.getId()).equals(userUrl)) {
    		refuseId.remove(session.getId());
    	}
    	else {
    		urlCount.put(userUrl, urlCount.get(userUrl) - 1);
    	}
    	System.out.println(urlCount.get(userUrl));
        clients.remove(session);
        System.out.println("클라이언트 연결이 종료되었습니다: " + session.getId());
    }
}