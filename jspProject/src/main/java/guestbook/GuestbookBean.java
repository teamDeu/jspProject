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

    // 기본 생성자
    public GuestbookBean() {}

    // 모든 필드를 포함한 생성자
    public GuestbookBean(int guestbookNum, String guestbookSecret, String ownerId, String writerId, String guestbookContent, Timestamp writtenAt, Timestamp modifiedAt) {
        this.guestbookNum = guestbookNum;
        this.guestbookSecret = guestbookSecret;
        this.ownerId = ownerId;
        this.writerId = writerId;
        this.guestbookContent = guestbookContent;
        this.writtenAt = writtenAt;
        this.modifiedAt = modifiedAt;
    }

    // Getter 및 Setter 메서드
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

    // toString 메서드 (디버깅 용도)
    @Override
    public String toString() {
        return "GuestbookBean{" +
                "guestbookNum=" + guestbookNum +
                ", guestbookSecret='" + guestbookSecret + '\'' +
                ", ownerId='" + ownerId + '\'' +
                ", writerId='" + writerId + '\'' +
                ", guestbookContent='" + guestbookContent + '\'' +
                ", writtenAt=" + writtenAt +
                ", modifiedAt=" + modifiedAt +
                '}';
    }
}

