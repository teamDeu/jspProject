package item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ItemMgr {
	private DBConnectionMgr pool;
	
	public ItemMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<ItemBean> getAllItems(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "select * from item";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ItemBean bean =  new ItemBean();
				bean.setItem_num(rs.getInt(1));
				bean.setItem_name(rs.getString(2));
				bean.setItem_image(rs.getString(3));
				bean.setItem_type(rs.getString(4));
				bean.setItem_price(rs.getInt(5));
				bean.setItem_path(rs.getString(6));
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
