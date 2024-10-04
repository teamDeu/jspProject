package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import miniroom.DBConnectionMgr;

public class BoardReAnswerMgr {
	private DBConnectionMgr pool;
	
	public BoardReAnswerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 답글 추가 메소드
	public boolean addReAnswer(BoardReAnswerBean reAnswerBean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "INSERT INTO boardreanswer (answer_num, reanswer_content, reanswer_id, reanswer_at) VALUES (?, ?, ?, now())";
	    
	    boolean result = false;

	    try {
	        // DB 연결 시도
	        con = pool.getConnection();
	        
	        // PreparedStatement 생성
	        pstmt = con.prepareStatement(sql);
	        
	        // 전달받은 데이터를 로그로 출력 (디버깅 용도)
	        System.out.println("Inserting answer_num: " + reAnswerBean.getAnswer_num());
	        System.out.println("Inserting reanswer_content: " + reAnswerBean.getReanswer_content());
	        System.out.println("Inserting reanswer_id: " + reAnswerBean.getReanswer_id());
	        
	        // 파라미터 설정
	        pstmt.setInt(1, reAnswerBean.getAnswer_num());
	        pstmt.setString(2, reAnswerBean.getReanswer_content());
	        pstmt.setString(3, reAnswerBean.getReanswer_id());

	        // 쿼리 실행 및 결과 확인
	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            result = true;  // 저장 성공
	            System.out.println("답글이 성공적으로 저장되었습니다.");
	        } else {
	            System.out.println("답글 저장에 실패하였습니다.");
	        }
	    } catch (Exception e) {
	        // 예외 발생 시 스택 트레이스를 출력하고 구체적인 에러 메시지 출력
	        System.out.println("Error occurred while inserting reAnswer: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        // 자원 반환
	        pool.freeConnection(con, pstmt);
	    }

	    return result;
	}
	
	public Vector<BoardReAnswerBean> getReAnswerList(int answer_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<BoardReAnswerBean> vlist = new Vector<BoardReAnswerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from boardreanswer where answer_num = ? order by reanswer_at desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, answer_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardReAnswerBean bean = new BoardReAnswerBean();
				bean.setReanswer_num(rs.getInt(1));
				bean.setAnswer_num(rs.getInt(2));
				bean.setReanswer_content(rs.getString(3));
				bean.setReanswer_id(rs.getString(4));
				bean.setReanswer_at(rs.getString(5));
				
				vlist.add(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

}
    
    
	
	
	
	

