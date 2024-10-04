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
	        // SQL문에서 item_type이 "음악"인 조건을 추가
	        sql = "SELECT i.item_name, i.item_path " +
	              "FROM itemhold ih " +
	              "JOIN item i ON ih.item_num = i.item_num " +
	              "WHERE ih.user_id = ? AND i.item_type = '음악'";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id); 
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));  
	            bean.setItem_path(rs.getString("item_path"));  // item_path 필드로 수정
	            vlist.add(bean); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist; 
	}
	
	public void deleteMusicByUserIdAndItemName(String user_id, String item_name) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        
        try {
            con = pool.getConnection();
            
            // item 테이블에서 item_name을 통해 item_num 조회
            sql = "SELECT item_num FROM item WHERE item_name = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, item_name);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int item_num = rs.getInt("item_num");
                
                // itemhold 테이블에서 user_id와 item_num에 해당하는 행을 삭제
                sql = "DELETE FROM itemhold WHERE user_id = ? AND item_num = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, user_id);
                pstmt.setInt(2, item_num);
                
                // 쿼리 실행
                pstmt.executeUpdate();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
    }




}

