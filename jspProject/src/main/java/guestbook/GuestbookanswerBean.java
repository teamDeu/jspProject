package guestbook;

import java.sql.Date;

public class GuestbookanswerBean {
    private int ganswerNum;
    private int guestbookNum;
    private String ganswerComment;
    private String ganswerId;
    private Date ganswerAt;
    private String profileName;
    private String profilePicture;

    // Getters and Setters
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

    public Date getGanswerAt() {
        return ganswerAt;
    }

    public void setGanswerAt(Date ganswerAt) {
        this.ganswerAt = ganswerAt;
    }
    public String getProfileName() {
        return profileName;
    }

    public void setProfileName(String profileName) {
        this.profileName = profileName;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }
}
