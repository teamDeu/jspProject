package report;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
