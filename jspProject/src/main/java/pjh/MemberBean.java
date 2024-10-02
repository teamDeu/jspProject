package pjh;

public class MemberBean {
    private String user_id;
    private String user_pwd;
    private String user_name;
    private String user_birth;
    private String user_phone;
    private String user_email;
    private int user_clover;
    private int user_character;
    private String user_date;
    
    // 기본 생성자
    public MemberBean() {}

    // 모든 필드를 포함하는 생성자
    public MemberBean(String user_id, String user_pwd, String user_name, String user_birth, String user_phone,
                      String user_email, int user_clover, int user_character, String user_date) {
        this.user_id = user_id;
        this.user_pwd = user_pwd;
        this.user_name = user_name;
        this.user_birth = user_birth;
        this.user_phone = user_phone;
        this.user_email = user_email;
        this.user_clover = user_clover;
        this.user_character = user_character;
        this.user_date = user_date;  // user_date 필드 추가
    }

    // Getters and Setters
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_pwd() {
        return user_pwd;
    }

    public void setUser_pwd(String user_pwd) {
        this.user_pwd = user_pwd;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_birth() {
        return user_birth;
    }

    public void setUser_birth(String user_birth) {
        this.user_birth = user_birth;
    }

    public String getUser_phone() {
        return user_phone;
    }

    public void setUser_phone(String user_phone) {
        this.user_phone = user_phone;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public int getUser_clover() {
        return user_clover;
    }

    public void setUser_clover(int user_clover) {
        this.user_clover = user_clover;
    }

    public int getUser_character() {
        return user_character;
    }

    public void setUser_character(int user_character) {
        this.user_character = user_character;
    }

    public String getUser_date() {
        return user_date;
    }

    public void setUser_date(String user_date) {
        this.user_date = user_date;
    }
}
