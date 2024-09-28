package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Statement;


public class GuestbookanswerMgr {
    private DBConnectionMgr pool;

    public GuestbookanswerMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // 답글 추가
    public int addAnswer(GuestbookanswerBean answer) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int ganswerNum = 0;
        String sql = "INSERT INTO guestbookanswer (guestbook_num, ganswer_comment, ganswer_id, ganswer_at) VALUES (?, ?, ?, NOW())";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, answer.getGuestbookNum());
            pstmt.setString(2, answer.getGanswerComment());
            pstmt.setString(3, answer.getGanswerId());
            pstmt.executeUpdate();

            // 생성된 키 가져오기
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                ganswerNum = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return ganswerNum;
    }


    // 답글 삭제
    public boolean deleteAnswer(int ganswerNum) {
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

    // 특정 guestbook_num에 해당하는 답글 조회
    public ArrayList<GuestbookanswerBean> getAnswers(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<GuestbookanswerBean> answerList = new ArrayList<>();
        String sql = "SELECT * FROM guestbookanswer WHERE guestbook_num = ? ORDER BY ganswer_at ASC";
        
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GuestbookanswerBean answer = new GuestbookanswerBean();
                answer.setGanswerNum(rs.getInt("ganswer_num"));
                answer.setGuestbookNum(rs.getInt("guestbook_num"));
                answer.setGanswerComment(rs.getString("ganswer_comment"));
                answer.setGanswerId(rs.getString("ganswer_id"));
                answer.setGanswerAt(rs.getTimestamp("ganswer_at"));
                answerList.add(answer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        
        return answerList;
    }

}
