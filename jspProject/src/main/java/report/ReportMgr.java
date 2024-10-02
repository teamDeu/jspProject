package report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ReportMgr {
	private DBConnectionMgr pool;
	
	public ReportMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void insertChatLog(ChatLogBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "insert chatlog values(null,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getChatlog_id());
			pstmt.setString(2, bean.getChatlog_content());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public boolean insertReport(ReportBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert report values(null,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getReport_senduserid());
			pstmt.setString(2, bean.getReport_receiveuserid());
			pstmt.setString(3, bean.getReport_type());
			if(pstmt.executeUpdate() == 1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public Vector<ReportBean> getAllReport(String type){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			con = pool.getConnection();
			sql = "select * from report order by report_num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReportBean bean = new ReportBean();
				bean.setReport_num(rs.getInt(1));
				bean.setReport_senduserid(rs.getString(2));
				bean.setReport_receiveuserid(rs.getString(3));
				bean.setReport_at(rs.getString(4));
				bean.setReport_type(rs.getString(5));
				
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
