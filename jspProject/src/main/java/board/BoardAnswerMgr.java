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

    // 댓글 삭제
    public void bdeleteAnswer(int answerNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM boardanswer WHERE answer_num = ?";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, answerNum);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("No comment found to delete with answer_num: " + answerNum);
            } else {
                System.out.println("Successfully deleted comment with answer_num: " + answerNum);
            }
        } catch (Exception e) {
            System.out.println("Error while deleting answer: " + e.getMessage());
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }

    // 댓글 목록 불러오기 (특정 게시물에 달린 댓글)
    public Vector<BoardAnswerBean> bgetAnswers(int boardNum) {
        Vector<BoardAnswerBean> answerList = new Vector<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM boardanswer WHERE board_num = ? ORDER BY answer_at ASC";

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
	
    // 특정 댓글의 answer_num을 가져오는 메소드
    public int getAnswerNumById(String answerId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int answerNum = -1; // 기본값은 -1로 설정

        try {
            con = pool.getConnection();
            String sql = "SELECT answer_num FROM boardanswer WHERE answer_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, answerId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                answerNum = rs.getInt("answer_num");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return answerNum; // 해당 answer_num을 반환
    }
    
}
