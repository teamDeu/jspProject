package mypage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MypageMgr {
    private DBConnectionMgr pool;

    public MypageMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) { // 모든 종류의 예외 처리
            e.printStackTrace();
        }
    }

    // Get user information by user_id
    public MypageBean getUserInfo(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MypageBean bean = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT user_id, user_name, user_birth, user_phone, user_email FROM user WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                bean = new MypageBean();
                bean.setUserId(rs.getString("user_id"));
                bean.setUserName(rs.getString("user_name"));
                bean.setUserBirth(rs.getDate("user_birth"));
                bean.setUserPhone(rs.getString("user_phone"));
                bean.setUserEmail(rs.getString("user_email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) { // getConnection() 에서 발생할 수 있는 예외 처리
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return bean;
    }

    // Update user information
    public boolean updateUserInfo(MypageBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean isUpdated = false;

        try {
            con = pool.getConnection();
            String sql = "UPDATE user SET user_name=?, user_birth=?, user_phone=?, user_email=? WHERE user_id=?";
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, bean.getUserName());
            
            if (bean.getUserBirth() != null) {
                pstmt.setDate(2, new java.sql.Date(bean.getUserBirth().getTime()));
            } else {
                pstmt.setNull(2, java.sql.Types.DATE);
            }

            pstmt.setString(3, bean.getUserPhone());
            pstmt.setString(4, bean.getUserEmail());
            pstmt.setString(5, bean.getUserId());
            
            System.out.println("Executing SQL: " + pstmt.toString()); // SQL 쿼리 디버깅
            
            int count = pstmt.executeUpdate();
            if (count > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // SQL 예외 디버깅
        } catch (Exception e) {
            e.printStackTrace(); // 일반 예외 디버깅
        } finally {
            pool.freeConnection(con, pstmt);
        }

        return isUpdated;
    }
}
