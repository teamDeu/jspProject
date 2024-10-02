package board;

public class BoardAnswerBean {
	private int answerNum;
    private int boardNum;
    private String answerContent;
    private String answerId;
    private String answerAt;
    
    public BoardAnswerBean() {}

    public BoardAnswerBean(int answerNum, int boardNum, String answerContent, String answerId, String answerAt) {
		super();
		this.answerNum = answerNum;
		this.boardNum = boardNum;
		this.answerContent = answerContent;
		this.answerId = answerId;
		this.answerAt = answerAt;
	}

	public int getAnswerNum() {
        return answerNum;
    }

    public void setAnswerNum(int answerNum) {
        this.answerNum = answerNum;
    }

    public int getBoardNum() {
        return boardNum;
    }

    public void setBoardNum(int boardNum) {
        this.boardNum = boardNum;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public String getAnswerId() {
        return answerId;
    }

    public void setAnswerId(String answerId) {
        this.answerId = answerId;
    }

    public String getAnswerAt() {
        return answerAt;
    }

    public void setAnswerAt(String answerAt) {
        this.answerAt = answerAt;
    }
}
