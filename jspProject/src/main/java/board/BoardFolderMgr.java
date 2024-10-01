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
    
    

    public BoardFolderBean getFolderInfo(int folderNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardFolderBean folder = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT folder_num, user_id, folder_name FROM boardfolder WHERE folder_num = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, folderNum);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                folder = new BoardFolderBean();
                folder.setFolder_num(rs.getInt("folder_num"));
                folder.setUser_id(rs.getString("user_id"));
                folder.setFolder_name(rs.getString("folder_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return folder;
    }
    public BoardFolderBean getLatestBoardFolder() {
    	Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardFolderBean bean = new BoardFolderBean();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM boardfolder order by folder_num desc Limit 1";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	bean.setUser_id(rs.getString(1));
            	bean.setFolder_num(rs.getInt(2));                
            	bean.setFolder_name(rs.getString(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return bean;
    }
    
    
    
}
