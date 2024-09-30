package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import guestbook.DBConnectionMgr;

public class GuestbookprofileMgr {
    private DBConnectionMgr pool;

    public GuestbookprofileMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 특정 userId에 대한 프로필 정보를 가져오는 메서드
    public GuestbookprofileBean getProfileByUserId(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        GuestbookprofileBean profile = null;

        try {
            con = pool.getConnection(); // Connection 가져오기
            String query = "SELECT user_id, profile_name, profile_picture FROM profile WHERE user_id = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                profile = new GuestbookprofileBean();
                profile.setUserId(rs.getString("user_id"));
                profile.setProfileName(rs.getString("profile_name"));
                profile.setProfilePicture(rs.getString("profile_picture"));
            }
        } catch (SQLException e) {
            // SQL 관련 예외 처리
            e.printStackTrace();
        } catch (Exception e) {
            // 일반적인 예외 처리
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close(); // pool로 반환
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return profile;
    }
}
