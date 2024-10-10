package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import miniroom.DBConnectionMgr;

public class BoardAnswerMgr {
	private DBConnectionMgr pool;
	
	public BoardAnswerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	// 댓글 추가
	public void binsertAnswer(BoardAnswerBean answerBean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO boardanswer (board_num, answer_content, answer_id, answer_at) VALUES (?, ?, ?, now())";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, answerBean.getBoardNum());
            pstmt.setString(2, answerBean.getAnswerContent());
            pstmt.setString(3, answerBean.getAnswerId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	pool.freeConnection(con, pstmt);
        }
    }

	/*
	 * // 댓글 삭제 public boolean bdeleteAnswer(int answerNum) { Connection con = null;
	 * PreparedStatement pstmt = null; String sql =
	 * "DELETE FROM boardanswer WHERE answer_num = ?"; boolean isDeleted = false;
	 * 
	 * try { con = pool.getConnection(); pstmt = con.prepareStatement(sql);
	 * pstmt.setInt(1, answerNum); int rowsAffected = pstmt.executeUpdate();
	 * 
	 * if (rowsAffected > 0) { // 댓글이 삭제되었을 경우 isDeleted = true;
	 * System.out.println("Successfully deleted comment with answer_num: " +
	 * answerNum); } else {
	 * System.out.println("No comment found to delete with answer_num: " +
	 * answerNum); } } catch (Exception e) {
	 * System.out.println("Error while deleting answer: " + e.getMessage());
	 * e.printStackTrace(); } finally { pool.freeConnection(con, pstmt); }
	 * 
	 * return isDeleted; // 삭제 성공 여부 반환 }
	 */
	
	
	// 댓글 삭제 메소드 수정 (댓글에 달린 답글도 함께 삭제)
	public boolean bdeleteAnswer(int answerNum) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    boolean isDeleted = false;
	    String deleteReAnswersSql = "DELETE FROM boardreanswer WHERE answer_num = ?";
	    String deleteAnswerSql = "DELETE FROM boardanswer WHERE answer_num = ?";

	    try {
	        con = pool.getConnection();
	        con.setAutoCommit(false); // 트랜잭션 시작

	        // 먼저 해당 댓글에 달린 답글을 삭제
	        pstmt = con.prepareStatement(deleteReAnswersSql);
	        pstmt.setInt(1, answerNum);
	        pstmt.executeUpdate();
	        pstmt.close();

	        // 댓글을 삭제
	        pstmt = con.prepareStatement(deleteAnswerSql);
	        pstmt.setInt(1, answerNum);
	        int rowsAffected = pstmt.executeUpdate();
	        
	        if (rowsAffected > 0) {
	            isDeleted = true;
	            con.commit(); // 트랜잭션 커밋
	            System.out.println("댓글과 답글이 성공적으로 삭제되었습니다.");
	        } else {
	            con.rollback(); // 트랜잭션 롤백
	            System.out.println("댓글 삭제에 실패했습니다.");
	        }

	    } catch (Exception e) {
	        try {
	            if (con != null) con.rollback(); // 오류 발생 시 롤백
	        } catch (Exception rollbackEx) {
	            rollbackEx.printStackTrace();
	        }
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }

	    return isDeleted;
	}

	
	
	public int getBoardByAnswersNum(int answerNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int boardNum = 0;
		try {
			con = pool.getConnection();
			sql = "select board_num from boardanswer where answer_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, answerNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				boardNum = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return boardNum;
	}
    // 댓글 목록 불러오기 (특정 게시물에 달린 댓글)
    public Vector<BoardAnswerBean> bgetAnswers(int boardNum) {
        Vector<BoardAnswerBean> answerList = new Vector<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM boardanswer WHERE board_num = ? ORDER BY answer_at DESC";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardAnswerBean answerBean = new BoardAnswerBean();
                answerBean.setAnswerNum(rs.getInt("answer_num"));
                answerBean.setBoardNum(rs.getInt("board_num"));
                answerBean.setAnswerContent(rs.getString("answer_content"));
                answerBean.setAnswerId(rs.getString("answer_id"));
                answerBean.setAnswerAt(rs.getString("answer_at"));
                answerList.add(answerBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	pool.freeConnection(con, pstmt, rs);
        }

        return answerList;
    }
	
    
    
}
