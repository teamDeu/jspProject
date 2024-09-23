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
	public String getItemPath(int item_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String itemPath = null;
		try {
			con = pool.getConnection();
			sql = "select item_path from item where item_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, item_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				itemPath = rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return itemPath;
	}
	
	public boolean updateMiniroom(int background , int character , String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update user set user_character = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, character);
			pstmt.setString(2, user_id);
			
			if(pstmt.executeUpdate() == 1) flag = true;
			else flag = false;
			
			sql = "update miniroom set miniroom_image = ? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, background);
			pstmt.setString(2, user_id);
			System.out.println("updateMiniroom");
			if(pstmt.executeUpdate() == 1) flag = true;
			else flag = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	public ItemBean getUsingCharacter(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ItemBean bean = new ItemBean();
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "SELECT i.item_num,i.item_path FROM item i JOIN user u ON i.item_num = u.user_character WHERE u.user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setItem_num(rs.getInt(1));
				bean.setItem_path(rs.getString(2));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public ItemBean getUsingBackground(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ItemBean bean = new ItemBean();
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "SELECT i.item_num,i.item_path FROM item i JOIN miniroom m ON i.item_num = m.miniroom_image WHERE m.user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setItem_num(rs.getInt(1));
				bean.setItem_path(rs.getString(2));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
}
