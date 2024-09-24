package friend;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FriendMgr {
	private DBConnectionMgr pool;
	
	public FriendMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean insertFriendRequest(FriendRequestBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert friendrequest(request_senduserid,request_receiveuserid,request_type,request_comment,request_at) VALUES (?,?,?,?,NOW())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRequest_senduserid());
			pstmt.setString(2, bean.getRequest_receiveuserid());
			pstmt.setInt(3, bean.getRequest_type());
			pstmt.setString(4, bean.getRequest_comment());
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
