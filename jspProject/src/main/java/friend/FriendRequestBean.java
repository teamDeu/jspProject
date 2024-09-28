package friend;

public class FriendRequestBean {
	private int request_num;
	private String request_senduserid;
	private String request_receiveuserid;
	private String request_at;
	private int request_type;
	public int getRequest_num() {
		return request_num;
	}

	public void setRequest_num(int request_num) {
		this.request_num = request_num;
	}

	private boolean request_complete;
	private String request_comment;

	public String getRequest_senduserid() {
		return request_senduserid;
	}

	public void setRequest_senduserid(String request_senduserid) {
		this.request_senduserid = request_senduserid;
	}

	public String getRequest_receiveuserid() {
		return request_receiveuserid;
	}

	public void setRequest_receiveuserid(String request_receiveuserid) {
		this.request_receiveuserid = request_receiveuserid;
	}

	public String getRequest_at() {
		return request_at;
	}

	public void setRequest_at(String request_at) {
		this.request_at = request_at;
	}

	public int getRequest_type() {
		return request_type;
	}

	public void setRequest_type(int request_type) {
		this.request_type = request_type;
	}

	public boolean isRequest_complete() {
		return request_complete;
	}

	public void setRequest_complete(boolean request_complete) {
		this.request_complete = request_complete;
	}

	public String getRequest_comment() {
		return request_comment;
	}

	public void setRequest_comment(String request_comment) {
		this.request_comment = request_comment;
	}

}
