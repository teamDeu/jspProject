package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import miniroom.DBConnectionMgr;
import miniroom.ItemBean;

public class BoardWriteMgr {
	private DBConnectionMgr pool;
	
	public BoardWriteMgr() {
		
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean addBoard(BoardWriteBean boardBean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "";
	    boolean flag = false;
	    try {
	        con = pool.getConnection();
	        // INSERT 쿼리 (이미지 처리 부분 포함)
	        sql = "INSERT INTO board (board_visibility, board_answertype, board_folder, board_id, board_title, board_content, board_at, board_image) " +
	              "VALUES (?, ?, ?, ?, ?, ?, now(), ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, boardBean.getBoard_visibility());
	        pstmt.setInt(2, boardBean.getBoard_answertype());
	        pstmt.setInt(3, boardBean.getBoard_folder());
	        pstmt.setString(4, boardBean.getBoard_id());
	        pstmt.setString(5, boardBean.getBoard_title());
	        pstmt.setString(6, boardBean.getBoard_content());

	        // 이미지 경로 설정 (null 또는 파일 경로)
	        if (boardBean.getBoard_image() != null && !boardBean.getBoard_image().isEmpty()) {
	            pstmt.setString(7, boardBean.getBoard_image());
	        } else {
	            pstmt.setNull(7, java.sql.Types.VARCHAR);
	        }

	        int rs = pstmt.executeUpdate();
	        if (rs > 0) {
	            flag = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;
	}
	
	
	// user_id에 해당하는 유효한 folder_num을 가져오는 메서드
    public int getIdFolderNum(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int folderNum = -1; // 유효한 폴더가 없을 경우 -1 반환
        try {
            con = pool.getConnection();
            String sql = "SELECT folder_num FROM boardfolder WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                folderNum = rs.getInt("folder_num"); // 첫 번째 유효한 폴더 번호 가져오기
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return folderNum;
    }

    // user_id와 folder_num이 유효한지 확인하는 메서드
    public boolean isFolderValid(String userId, int folderNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValid = false;
        try {
            con = pool.getConnection();
            String sql = "SELECT COUNT(*) FROM boardfolder WHERE user_id = ? AND folder_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2, folderNum);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isValid = true; // 유효한 폴더가 있으면 true 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return isValid;
    }
	
    // 특정 폴더에 해당하는 게시글 목록을 가져오는 메서드
    public Vector<BoardWriteBean> getBoardList(int boardFolder) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<BoardWriteBean> boardList = new Vector<>(); // Vector 사용
        try {
            con = pool.getConnection();
            String sql = "SELECT board_num, board_visibility, board_answertype, board_folder, board_id, board_title, board_content, board_at, board_image, "
            		+ "board_views FROM board WHERE board_folder = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, boardFolder);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardWriteBean board = new BoardWriteBean();
                board.setBoard_num(rs.getInt("board_num"));
                board.setBoard_visibility(rs.getInt("board_visibility"));
                board.setBoard_answertype(rs.getInt("board_answertype"));
                board.setBoard_folder(rs.getInt("board_folder"));
                board.setBoard_id(rs.getString("board_id"));
                board.setBoard_title(rs.getString("board_title"));
                board.setBoard_content(rs.getString("board_content"));
                board.setBoard_at(rs.getTimestamp("board_at").toString());
                board.setBoard_image(rs.getString("board_image"));
                board.setBoard_views(rs.getInt("board_views"));
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return boardList;
    }
	
    
    
    
    
    // 특정 board_num에 해당하는 게시글을 삭제하는 메서드
    public boolean deleteBoard(int boardNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        boolean isDeleted = false;
        try {
            con = pool.getConnection();
            sql = "DELETE FROM board WHERE board_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            int result = pstmt.executeUpdate();

            if (result > 0) { // 삭제된 행이 있으면 true 반환
                isDeleted = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return isDeleted;
    }

    // 여러 개의 게시글을 한 번에 삭제하는 메서드
    public boolean deleteMultipleBoards(int[] boardNums) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        boolean isAllDeleted = true; // 모두 성공적으로 삭제되었는지 확인
        try {
            con = pool.getConnection();
            sql = "DELETE FROM board WHERE board_num = ?";
            pstmt = con.prepareStatement(sql);

            for (int boardNum : boardNums) {
                pstmt.setInt(1, boardNum);
                int result = pstmt.executeUpdate();
                if (result == 0) {
                    isAllDeleted = false; // 삭제되지 않은 항목이 있으면 false 설정
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            isAllDeleted = false;
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return isAllDeleted;
    }
	
    // 특정 board_num에 해당하는 게시물의 조회수를 1 증가시키는 메서드
    public boolean increaseViews(int boardNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "";
        boolean isUpdated = false;
        try {
            con = pool.getConnection();
            sql = "UPDATE board SET board_views = board_views + 1 WHERE board_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, boardNum);
            int result = pstmt.executeUpdate();

            if (result > 0) { // 업데이트된 행이 있으면 true 반환
                isUpdated = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return isUpdated;
    }
    
    //최근 게시물 불러오는 메서드
    public BoardWriteBean getLatestBoard() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardWriteBean board = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM board ORDER BY board_at DESC LIMIT 1"; // 최근 게시된 글 1개 가져오기
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                board = new BoardWriteBean();
                board.setBoard_num(rs.getInt("board_num"));
                board.setBoard_visibility(rs.getInt("board_visibility"));
                board.setBoard_answertype(rs.getInt("board_answertype"));
                board.setBoard_folder(rs.getInt("board_folder"));
                board.setBoard_id(rs.getString("board_id"));
                board.setBoard_title(rs.getString("board_title"));
                board.setBoard_content(rs.getString("board_content"));
                board.setBoard_at(rs.getTimestamp("board_at").toString());
                board.setBoard_image(rs.getString("board_image"));
                board.setBoard_views(rs.getInt("board_views"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return board;
    }
    
}
