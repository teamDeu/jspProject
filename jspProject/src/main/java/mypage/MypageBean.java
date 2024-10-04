package mypage;

import java.sql.Date;

public class MypageBean {
    private String userId;
    private String userPwd;
    private String userName;
    private Date userBirth;
    private String userPhone;
    private String userEmail;
    private int userClover;
    private Integer userCharacter; // Can be null
    private Date userDate;

    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getUserBirth() {
        return userBirth;
    }

    public void setUserBirth(Date userBirth) {
        this.userBirth = userBirth;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getUserClover() {
        return userClover;
    }

    public void setUserClover(int userClover) {
        this.userClover = userClover;
    }

    public Integer getUserCharacter() {
        return userCharacter;
    }

    public void setUserCharacter(Integer userCharacter) {
        this.userCharacter = userCharacter;
    }

    public Date getUserDate() {
        return userDate;
    }

    public void setUserDate(Date userDate) {
        this.userDate = userDate;
    }
}

