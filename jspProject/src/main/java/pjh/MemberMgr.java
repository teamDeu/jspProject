package pjh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import java.util.Vector;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;

public class MemberMgr {

    private DBConnectionMgr pool;
    private DefaultMessageService messageService;

    public MemberMgr() {
        pool = DBConnectionMgr.getInstance();
        // 메시지 서비스 초기화
        messageService = NurigoApp.INSTANCE.initialize("NCS05PHUJJCQP4KS", "GVI8ZIVSAONHOZGGTXDHCDHXGMW6SSSY", "https://api.coolsms.co.kr");
    }
    
    // ID 중복확인
    public boolean checkId(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag  = false;
        try {
            con = pool.getConnection();
            sql = "select user_id from user where user_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            flag = rs.next(); // true이면 중복, false 중복 아님
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return flag;
    }
    
    
    // 회원가입
    public boolean insertMember(MemberBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            // 비밀번호 확인은 따로 저장하지 않고, 비밀번호와 일치 여부만 클라이언트에서 처리
            sql = "insert into user(user_id, user_pwd, user_name, user_birth, user_phone, user_email, user_clover, user_character)"
                    + "values(?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getUser_id());
            pstmt.setString(2, bean.getUser_pwd());
            pstmt.setString(3, bean.getUser_name());
            pstmt.setString(4, bean.getUser_birth());
            pstmt.setString(5, bean.getUser_phone());
            pstmt.setString(6, bean.getUser_email());
            pstmt.setInt(7, bean.getUser_clover());
            pstmt.setInt(8, 1);
            if (pstmt.executeUpdate() == 1)
                flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }
    
    
    
    
    // 로그인
    
    
    public int loginMember(String id, String pwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int mode = 0;
        try {
            if (!checkId(id))
                return mode;
            con = pool.getConnection();
            sql = "select user_id, user_pwd from user where user_id = ? and user_pwd = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();
            if (rs.next())
                mode = 2; // 로그인 성공
            else
                mode = 1; // 비밀번호 불일치
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return mode;
    }
    
    // 회원정보 가져오기
    public MemberBean getMember(String id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        MemberBean bean = new MemberBean();
        try {
            con = pool.getConnection();
            sql = "select * from user where user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bean.setUser_id(rs.getString("user_id"));
                bean.setUser_pwd(rs.getString("user_pwd"));
                bean.setUser_name(rs.getString("user_name"));
                bean.setUser_birth(rs.getString("user_birth"));
                bean.setUser_phone(rs.getString("user_phone"));
                bean.setUser_email(rs.getString("user_email"));
                bean.setUser_clover(rs.getInt("user_clover"));
                bean.setUser_character(rs.getInt("user_character"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return bean;
    }


// 인증번호 생성
public String generateAuthCode() {
    Random rand = new Random();
    StringBuilder authCode = new StringBuilder();
    for (int i = 0; i < 6; i++) { // 6자리 인증번호 생성
        authCode.append(rand.nextInt(10)); // 0~9 숫자 생성
    }
    return authCode.toString();
}

// 인증번호 전송
public boolean sendAuthCode(String phoneNumber, String authCode) {
    Message message = new Message();
    message.setFrom("01080131233");
    message.setTo(phoneNumber);
    message.setText("인증번호는 " + authCode + " 입니다.");

    try {
        messageService.send(message); // 인증번호 전송
        return true;
    } catch (NurigoMessageNotReceivedException exception) {
        System.out.println(exception.getFailedMessageList());
        System.out.println(exception.getMessage());
        return false;
    } catch (Exception exception) {
        System.out.println(exception.getMessage());
        return false;
    }
}
}

