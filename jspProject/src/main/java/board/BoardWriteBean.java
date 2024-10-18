package board;

public class BoardWriteBean {
	private int board_num; // 게시물 번호
    private int board_visibility; // 공개 설정 (0: 전체, 1: 일촌)
    private int board_answertype; // 댓글 허용 여부 (0: 비허용, 1: 허용)
    private int board_folder; // 폴더 번호 (카테고리)
    private String board_id; // 작성자 ID
    private String board_title; // 게시물 제목
    private String board_content; // 게시물 내용
    private String board_at; // 작성 시간
    private String board_image; // 이미지 경로
    private int board_views;
    private String board_updated_at; //게시글 수정 날짜
    
    
    public BoardWriteBean(){}
	 
    

	public BoardWriteBean(int board_num, int board_visibility, int board_answertype, int board_folder, String board_id,
			String board_title, String board_content, String board_at, String board_image, int board_views,
			String board_updated_at) {
		super();
		this.board_num = board_num;
		this.board_visibility = board_visibility;
		this.board_answertype = board_answertype;
		this.board_folder = board_folder;
		this.board_id = board_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_at = board_at;
		this.board_image = board_image;
		this.board_views = board_views;
		this.board_updated_at = board_updated_at;
	}



	public int getBoard_num() {
        return board_num;
    }

    public void setBoard_num(int board_num) {
        this.board_num = board_num;
    }

    public int getBoard_visibility() {
        return board_visibility;
    }

    public void setBoard_visibility(int board_visibility) {
        this.board_visibility = board_visibility;
    }

    public int getBoard_answertype() {
        return board_answertype;
    }

    public void setBoard_answertype(int board_answertype) {
        this.board_answertype = board_answertype;
    }

    public int getBoard_folder() {
        return board_folder;
    }

    public void setBoard_folder(int board_folder) {
        this.board_folder = board_folder;
    }

    public String getBoard_id() {
        return board_id;
    }

    public void setBoard_id(String board_id) {
        this.board_id = board_id;
    }

    public String getBoard_title() {
        return board_title;
    }

    public void setBoard_title(String board_title) {
        this.board_title = board_title;
    }

    public String getBoard_content() {
        return board_content;
    }

    public void setBoard_content(String board_content) {
        this.board_content = board_content;
    }

    public String getBoard_at() {
        return board_at;
    }

    public void setBoard_at(String board_at) {
        this.board_at = board_at;
    }

    public String getBoard_image() {
        return board_image;
    }

    public void setBoard_image(String board_image) {
        this.board_image = board_image;
    }

	public int getBoard_views() {
		return board_views;
	}

	public void setBoard_views(int board_views) {
		this.board_views = board_views;
	}

	public String getBoard_updated_at() {
		return board_updated_at;
	}

	public void setBoard_updated_at(String board_updated_at) {
		this.board_updated_at = board_updated_at;
	}
    
    
    
}
