package board;

public class BoardFolderBean {
	private String user_id;
	private int folder_num;
	private String folder_name;
	
	public BoardFolderBean() {}

	public BoardFolderBean(String user_id, int folder_num, String folder_name) {
		super();
		this.user_id = user_id;
		this.folder_num = folder_num;
		this.folder_name = folder_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getFolder_num() {
		return folder_num;
	}

	public void setFolder_num(int folder_num) {
		this.folder_num = folder_num;
	}

	public String getFolder_name() {
		return folder_name;
	}

	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
	}
	
	
	
}

