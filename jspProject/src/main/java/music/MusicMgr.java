package music;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class MusicMgr {
	private DBConnectionMgr pool;
	
	public MusicMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<MusicBean> getMusicList(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<MusicBean> vlist = new Vector<MusicBean>();
	    try {
	        con = pool.getConnection();
	        sql = "SELECT i.item_name, m.music_path " +
	              "FROM itemhold ih " +
	              "JOIN item i ON ih.item_num = i.item_num " +
	              "JOIN music m ON ih.item_num = m.item_num " +
	              "WHERE ih.user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id); 
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	        	MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));  
	            bean.setMusic_path(rs.getString("music_path"));  
	            vlist.add(bean); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist; 
	}



}

