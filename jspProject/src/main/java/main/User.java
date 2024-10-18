package main;

import javax.websocket.Session;

public class User {
	private Session session;
	private String userId;
	private String connectedUrl;
	private String userName;
	private String userCharacter;
	
	User(Session session,String userId,String connectedUrl, String userName, String userCharacter){
		this.session = session;
		this.userId = userId;
		this.connectedUrl = connectedUrl;
		this.userName = userName;
		this.userCharacter = userCharacter;
	}

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getConnectedUrl() {
		return connectedUrl;
	}

	public void setConnectedUrl(String connectedUrl) {
		this.connectedUrl = connectedUrl;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserCharacter() {
		return userCharacter;
	}

	public void setUserCharacter(String userCharacter) {
		this.userCharacter = userCharacter;
	}
	
	
}
