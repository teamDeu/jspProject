package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import miniroom.DBConnectionMgr;

public class BoardReAnswerMgr {
	private DBConnectionMgr pool;
	
	public BoardReAnswerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 답글 추가 메소드
    public boolean addReAnswer(BoardReAnswerBean reAnswer) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO boardreanswer (reanswer_num, answer_num, reanswer_content, reanswer_id, reanswer_at) VALUES (NULL, ?, ?, ?, NOW())";       
        boolean result = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, reAnswer.getAnswer_num());
            pstmt.setString(2, reAnswer.getReanswer_content());
            pstmt.setString(3, reAnswer.getReanswer_id());

            int count = pstmt.executeUpdate();
            if (count > 0) {
                result = true; 
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }

        return result;
    }
    
    
	
	
	
	
}
