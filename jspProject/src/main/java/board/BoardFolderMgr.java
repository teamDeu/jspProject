package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import miniroom.DBConnectionMgr;

public class BoardFolderMgr {
	private DBConnectionMgr pool;
	
	public BoardFolderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean addFolder(BoardFolderBean folder) {
		Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO boardfolder (user_id, folder_name) VALUES (?, ?)";
        boolean result = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, folder.getUser_id());
            pstmt.setString(2, folder.getFolder_name());
            int count = pstmt.executeUpdate();
            result = (count > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return result;
	}
	
	
	// 폴더 삭제
    public boolean deleteFolder(int folderNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM boardfolder WHERE folder_num = ?";
        boolean result = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, folderNum);
            int count = pstmt.executeUpdate();
            result = (count > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return result;
    }
    

    // 사용자 ID로 폴더 목록 
    public Vector<BoardFolderBean> getFolderList(String userId) {
        Vector<BoardFolderBean> folderList = new Vector<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT folder_num, folder_name FROM boardfolder WHERE user_id = ? ORDER BY folder_num";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardFolderBean folder = new BoardFolderBean();
                folder.setFolder_num(rs.getInt("folder_num"));
                folder.setFolder_name(rs.getString("folder_name"));
                folderList.add(folder);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return folderList;
    }
    
    

    public int getFolderNum(String userId) { 
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int folderNum = -1;

        try {
            con = pool.getConnection();

            String sql = "SELECT folder_num FROM boardfolder WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                folderNum = rs.getInt("folder_num");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return folderNum;
    }
    
    
    // 사용자 ID로 가장 최근에 추가된 폴더 번호 가져오기
    public int getRecentFolderNum(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int folderNum = -1;

        try {
            con = pool.getConnection();
            String sql = "SELECT MAX(folder_num) AS folder_num FROM boardfolder WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                folderNum = rs.getInt("folder_num");
                System.out.println("최근 폴더 번호: " + folderNum); // 디버그 로그 추가
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("폴더 번호를 가져오는 데 실패했습니다."); // 예외 발생 시 로그 출력
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return folderNum;
    }
    
}
