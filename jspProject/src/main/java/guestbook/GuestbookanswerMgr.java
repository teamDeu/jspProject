package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GuestbookanswerMgr {
    private DBConnectionMgr pool;

    public GuestbookanswerMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // Add a new reply to a guestbook entry
 // GuestbookanswerMgr.java
    public boolean addGuestbookAnswer(GuestbookanswerBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "INSERT INTO guestbookanswer (guestbook_num, ganswer_comment, ganswer_id, ganswer_at) VALUES (?, ?, ?, NOW())";
        boolean isSuccess = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, bean.getGuestbookNum());
            pstmt.setString(2, bean.getGanswerComment());
            pstmt.setString(3, bean.getGanswerId());
            int count = pstmt.executeUpdate();

            // 추가된 답글의 ID를 가져옴
            if (count > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int answerNum = rs.getInt(1); // 생성된 답글 ID 가져오기
                    bean.setGanswerNum(answerNum); // 생성된 ID를 bean에 설정
                    isSuccess = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return isSuccess;
    }

 // Get all replies for a specific guestbook entry, including profile information
    public ArrayList<GuestbookanswerBean> getAnswersForGuestbook(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<GuestbookanswerBean> list = new ArrayList<>();
        // 수정된 쿼리: 'profile' 테이블로 변경
        String sql = "SELECT ga.*, p.profile_name, p.profile_picture FROM guestbookanswer ga " +
                     "LEFT JOIN profile p ON ga.ganswer_id = p.user_id " +
                     "WHERE ga.guestbook_num = ? ORDER BY ga.ganswer_at ASC";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GuestbookanswerBean bean = new GuestbookanswerBean();
                bean.setGanswerNum(rs.getInt("ganswer_num"));
                bean.setGuestbookNum(rs.getInt("guestbook_num"));
                bean.setGanswerComment(rs.getString("ganswer_comment"));
                bean.setGanswerId(rs.getString("ganswer_id"));
                bean.setGanswerAt(rs.getDate("ganswer_at"));
                // 프로필 정보 추가
                bean.setProfileName(rs.getString("profile_name"));
                bean.setProfilePicture(rs.getString("profile_picture"));
                list.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return list;
    }
    
    public GuestbookanswerBean getAnswersByNum(int ganswer_num) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		GuestbookanswerBean bean = new GuestbookanswerBean();
		try {
			con = pool.getConnection();
			sql = "select * from guestbookanswer where ganswer_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ganswer_num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				bean.setGanswerNum(rs.getInt("ganswer_num"));
                bean.setGuestbookNum(rs.getInt("guestbook_num"));
                bean.setGanswerComment(rs.getString("ganswer_comment"));
                bean.setGanswerId(rs.getString("ganswer_id"));
                bean.setGanswerAt(rs.getDate("ganswer_at"));
                // 프로필 정보 추가
                bean.setProfileName(rs.getString("profile_name"));
                bean.setProfilePicture(rs.getString("profile_picture"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
    }


    // Delete a specific reply
    public boolean deleteGuestbookAnswer(int ganswerNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM guestbookanswer WHERE ganswer_num = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, ganswerNum);
            int count = pstmt.executeUpdate();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return false;
    }

    // Delete all replies for a specific guestbook entry
    public boolean deleteAllAnswersForGuestbook(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM guestbookanswer WHERE guestbook_num = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);
            int count = pstmt.executeUpdate();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return false;
    }
    
    public int getLatestGuestbookAnswer() {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int ganswer_num = 0;
		try {
			con = pool.getConnection();
			sql = "select ganswer_num from guestbookanswer order by ganswer_num desc limit 1";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ganswer_num = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ganswer_num;
    }
}
