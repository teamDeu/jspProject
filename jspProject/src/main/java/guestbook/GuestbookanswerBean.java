package guestbook;

import java.sql.Timestamp;

public class GuestbookanswerBean {
    private int ganswerNum;
    private int guestbookNum;
    private String ganswerComment;
    private String ganswerId;
    private Timestamp ganswerAt;

    public int getGanswerNum() {
        return ganswerNum;
    }

    public void setGanswerNum(int ganswerNum) {
        this.ganswerNum = ganswerNum;
    }

    public int getGuestbookNum() {
        return guestbookNum;
    }

    public void setGuestbookNum(int guestbookNum) {
        this.guestbookNum = guestbookNum;
    }

    public String getGanswerComment() {
        return ganswerComment;
    }

    public void setGanswerComment(String ganswerComment) {
        this.ganswerComment = ganswerComment;
    }

    public String getGanswerId() {
        return ganswerId;
    }

    public void setGanswerId(String ganswerId) {
        this.ganswerId = ganswerId;
    }

    public Timestamp getGanswerAt() {
        return ganswerAt;
    }

    public void setGanswerAt(Timestamp ganswerAt) {
        this.ganswerAt = ganswerAt;
    }
}
