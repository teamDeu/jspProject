package miniroom;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ItemMgr {
	private DBConnectionMgr pool;
	
	public ItemMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<ItemBean> getHoldCharacter(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT i.item_num,item_name,item_image,item_type,item_price,item_path FROM itemhold ih JOIN item i ON ih.item_num = i.item_num WHERE user_id = ? and item_type = '캐릭터'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemBean bean = new ItemBean();
				bean.setItem_num(rs.getInt(1));
				bean.setItem_name(rs.getString(2));
				bean.setItem_image(rs.getString(3));
				bean.setItem_type(rs.getString(4));
				bean.setItem_price(rs.getInt(5));
				bean.setItem_path(rs.getString(6));
				vlist.add(bean);
			}
		} catch (Exception e) {
			System.err.println("캐릭터정보 오류");
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<ItemBean> getHoldBackgroundImg(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT i.item_num,item_name,item_image,item_type,item_price,item_path FROM itemhold ih JOIN item i ON ih.item_num = i.item_num WHERE user_id = ? and item_type = '배경화면'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemBean bean = new ItemBean();
				bean.setItem_num(rs.getInt(1));
				bean.setItem_name(rs.getString(2));
				bean.setItem_image(rs.getString(3));
				bean.setItem_type(rs.getString(4));
				bean.setItem_price(rs.getInt(5));
				bean.setItem_path(rs.getString(6));
				vlist.add(bean);
			}
		} catch (Exception e) {
			System.err.println("배경정보 오류");
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
}
