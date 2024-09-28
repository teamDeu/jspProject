package pjh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import miniroom.DBConnectionMgr;

public class AdminMgr {
    private DBConnectionMgr pool;

    public AdminMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            System.out.println("Error: DB Connection Failed");
        }
    }

    // 관리자 로그인 메서드
    public int loginAdmin(String admin_id, String admin_pwd) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;  // 0: 아이디 없음, 1: 비밀번호 불일치, 2: 로그인 성공

        try {
            conn = pool.getConnection();
            String sql = "SELECT admin_pwd FROM admin WHERE admin_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, admin_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPwd = rs.getString("admin_pwd");
                if (dbPwd.equals(admin_pwd)) {
                    result = 2;  // 로그인 성공
                } else {
                    result = 1;  // 비밀번호 불일치
                }
            } else {
                result = 0;  // 아이디 없음
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }

        return result;
    }

    // 관리자 정보를 ID로 가져오는 메서드
    public AdminBean getAdminById(String admin_id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        AdminBean adminInfo = null;

        try {
            conn = pool.getConnection();
            String sql = "SELECT * FROM admin WHERE admin_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, admin_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                adminInfo = new AdminBean();
                adminInfo.setAdmin_id(rs.getString("admin_id"));
                adminInfo.setAdmin_pwd(rs.getString("admin_pwd"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }

        return adminInfo;
    }
}
