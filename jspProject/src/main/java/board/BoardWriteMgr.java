package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import miniroom.DBConnectionMgr;
import miniroom.ItemBean;

public class BoardWriteMgr {
private DBConnectionMgr pool;
	
	public BoardWriteMgr() {
		
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean insertBoard(BoardWriteBean boardBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into board (board_visibility, board_answertype, board_folder, board_id, board_title, board_content, board_at, board_image) VALUES (?, ?, ?, ?, ?, ?, now(), ?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardBean.getBoard_visibility());
            pstmt.setInt(2, boardBean.getBoard_answertype());
            pstmt.setInt(3, boardBean.getBoard_folder());
            pstmt.setString(4, boardBean.getBoard_id());
            pstmt.setString(5, boardBean.getBoard_title());
            pstmt.setString(6, boardBean.getBoard_content());     
            pstmt.setString(7, boardBean.getBoard_image());
			int rs = pstmt.executeUpdate();
			
			if (rs > 0) { // 쿼리 실행 결과가 0보다 크면 성공
                flag = true;
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	
	
	
	
	
	
}
