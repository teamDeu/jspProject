package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import miniroom.DBConnectionMgr;
import miniroom.ItemBean;

public class BoardWriteMgr {
	
	public static final String  SAVEFOLDER = "C:/project/jspProject/jspProject/src/main/webapp/seyoung/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 100*1024*1024;
	
	private DBConnectionMgr pool;
	
	public BoardWriteMgr() {
		
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean addBoard(MultipartRequest multi) {
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

            // 폼 데이터 가져오기
            pstmt.setInt(1, Integer.parseInt(multi.getParameter("board_visibility")));
            pstmt.setInt(2, Integer.parseInt(multi.getParameter("board_answertype")));
            pstmt.setInt(3, Integer.parseInt(multi.getParameter("board_folder")));
            pstmt.setString(4, multi.getParameter("board_id"));
            pstmt.setString(5, multi.getParameter("board_title"));
            pstmt.setString(6, multi.getParameter("board_content"));

            // 이미지 경로 설정 (null 또는 파일 경로)
            String boardImage = multi.getFilesystemName("board_image");
            if (boardImage != null && !boardImage.isEmpty()) {
                pstmt.setString(7, "./img/" + boardImage);
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
	
    
    
    
    //boardList.jsp에서 체크박스로 게시물 삭제 -> 배열로
    public boolean deleteMultipleBoards(int[] boardNums) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean isAllDeleted = true; // 모두 성공적으로 삭제되었는지 확인
        try {
            con = pool.getConnection();

            // 1. 각 게시글의 댓글과 대댓글을 먼저 삭제
            for (int boardNum : boardNums) {
                // 1.1 대댓글 삭제
                String deleteReAnswersSql = "DELETE FROM boardreanswer WHERE answer_num IN (SELECT answer_num FROM boardanswer WHERE board_num = ?)";
                pstmt = con.prepareStatement(deleteReAnswersSql);
                pstmt.setInt(1, boardNum);
                pstmt.executeUpdate();
                pstmt.close();

                // 1.2 댓글 삭제
                String deleteAnswersSql = "DELETE FROM boardanswer WHERE board_num = ?";
                pstmt = con.prepareStatement(deleteAnswersSql);
                pstmt.setInt(1, boardNum);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // 2. 그 다음에 게시글 삭제
            String deleteBoardsSql = "DELETE FROM board WHERE board_num = ?";
            pstmt = con.prepareStatement(deleteBoardsSql);
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
    
    // userId에 해당하는 사용자의 게시글 목록을 가져오는 메서드 추가
    public Vector<BoardWriteBean> getBoardListByUser(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<BoardWriteBean> boardList = new Vector<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM board WHERE board_id = ? ORDER BY board_at DESC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
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
    
    
    // 게시글 삭제 메서드 (댓글과 대댓글도 함께 삭제) (board.jsp)
    public boolean deletePostAndComments(int boardNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean isDeleted = false;
        String deleteReAnswersSql = "DELETE FROM boardreanswer WHERE answer_num IN (SELECT answer_num FROM boardanswer WHERE board_num = ?)";
        String deleteAnswersSql = "DELETE FROM boardanswer WHERE board_num = ?";
        String deleteBoardSql = "DELETE FROM board WHERE board_num = ?";

        try {
            con = pool.getConnection();
            con.setAutoCommit(false); // 트랜잭션 시작

            // 1. 댓글에 달린 대댓글 삭제
            pstmt = con.prepareStatement(deleteReAnswersSql);
            pstmt.setInt(1, boardNum);
            pstmt.executeUpdate();
            pstmt.close();

            // 2. 댓글 삭제
            pstmt = con.prepareStatement(deleteAnswersSql);
            pstmt.setInt(1, boardNum);
            pstmt.executeUpdate();
            pstmt.close();

            // 3. 게시글 삭제
            pstmt = con.prepareStatement(deleteBoardSql);
            pstmt.setInt(1, boardNum);
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                isDeleted = true;
                con.commit(); // 트랜잭션 커밋
            } else {
                con.rollback(); // 삭제 실패 시 롤백
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
    
    
    // 삭제된 게시글 다음 최신 게시글을 불러오는 메서드  (board.jsp)
    public BoardWriteBean getNextLatestBoard(int deletedBoardNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardWriteBean board = null;
        try {
            con = pool.getConnection();
            // 삭제된 게시글 다음으로 최신 게시글을 불러옴
            String sql = "SELECT * FROM board WHERE board_num < ? ORDER BY board_num DESC LIMIT 1";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, deletedBoardNum);
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
