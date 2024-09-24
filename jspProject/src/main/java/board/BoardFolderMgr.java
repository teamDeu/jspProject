package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
	
	
	// 폴더 삭제 메서드
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
}
