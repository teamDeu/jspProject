package guestbook;

import java.sql.Timestamp;

public class GuestbookBean {
    private int guestbookNum;
    private String guestbookSecret;
    private String ownerId;
    private String writerId;
    private String guestbookContent;
    private Timestamp writtenAt;
    private Timestamp modifiedAt;

    private String profileName;
    private String profilePicture;
    
    public int getGuestbookNum() {
        return guestbookNum;
    }

    public void setGuestbookNum(int guestbookNum) {
        this.guestbookNum = guestbookNum;
    }

    public String getGuestbookSecret() {
        return guestbookSecret;
    }

    public void setGuestbookSecret(String guestbookSecret) {
        this.guestbookSecret = guestbookSecret;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public String getWriterId() {
        return writerId;
    }

    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }

    public String getGuestbookContent() {
        return guestbookContent;
    }

    public void setGuestbookContent(String guestbookContent) {
        this.guestbookContent = guestbookContent;
    }

    public Timestamp getWrittenAt() {
        return writtenAt;
    }

    public void setWrittenAt(Timestamp writtenAt) {
        this.writtenAt = writtenAt;
    }

    public Timestamp getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(Timestamp modifiedAt) {
        this.modifiedAt = modifiedAt;
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
