package friend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import pjh.MemberBean;

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
	
	public FriendRequestBean getLastFriendRequest() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		FriendRequestBean bean = new FriendRequestBean();
		try {
			con = pool.getConnection();
			sql = "select * from friendrequest ORDER BY request_num DESC LIMIT 1 ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				bean.setRequest_num(rs.getInt(1));
				bean.setRequest_receiveuserid(rs.getString("request_receiveuserid"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public boolean insertFriendInfo(FriendRequestBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert friendinfo values(null,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRequest_senduserid());
			pstmt.setString(2, bean.getRequest_receiveuserid());
			pstmt.setInt(3, bean.getRequest_type());
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public Vector<FriendInfoBean> getFriendList(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<FriendInfoBean> vlist = new Vector<FriendInfoBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendinfo where user_id1 = ? or user_id2 = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendInfoBean bean = new FriendInfoBean();
				bean.setFriend_num(rs.getInt("friend_num"));
				bean.setUser_id1(rs.getString("user_id1"));
				bean.setUser_id2(rs.getString("user_id2"));
				bean.setFriend_at(rs.getString("friend_at"));
				bean.setFriend_type(rs.getInt("friend_type"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<FriendRequestBean> getFriendRequest(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<FriendRequestBean> vlist = new Vector<FriendRequestBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendrequest where request_receiveuserid = ? and request_complete = 0 order by request_at desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendRequestBean bean = new FriendRequestBean();
				bean.setRequest_num(rs.getInt(1));
				bean.setRequest_senduserid(rs.getString(2));
				bean.setRequest_receiveuserid(rs.getString(3));
				bean.setRequest_at(rs.getString(4));
				bean.setRequest_type(rs.getInt(5));
				bean.setRequest_comment(rs.getString(7));
				vlist.add(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public Vector<FriendInfoBean> getALLFriendList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<FriendInfoBean> vlist = new Vector<FriendInfoBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendinfo";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendInfoBean bean = new FriendInfoBean();
				bean.setFriend_num(rs.getInt("friend_num"));
				bean.setUser_id1(rs.getString("user_id1"));
				bean.setUser_id2(rs.getString("user_id2"));
				bean.setFriend_at(rs.getString("friend_at"));
				bean.setFriend_type(rs.getInt("friend_type"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public Vector<FriendRequestBean> getAllFriendRequest() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<FriendRequestBean> vlist = new Vector<FriendRequestBean>();
		try {
			con = pool.getConnection();
			sql = "select * from friendrequest where request_complete = 0 order by request_at desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FriendRequestBean bean = new FriendRequestBean();
				bean.setRequest_num(rs.getInt(1));
				bean.setRequest_senduserid(rs.getString(2));
				bean.setRequest_receiveuserid(rs.getString(3));
				bean.setRequest_at(rs.getString(4));
				bean.setRequest_type(rs.getInt(5));
				bean.setRequest_comment(rs.getString(7));
				vlist.add(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	public FriendRequestBean getFriendRequestItem(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		FriendRequestBean bean = new FriendRequestBean();
		try {
			con = pool.getConnection();
			sql = "select * from friendrequest where request_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setRequest_num(rs.getInt(1));
				bean.setRequest_senduserid(rs.getString(2));
				bean.setRequest_receiveuserid(rs.getString(3));
				bean.setRequest_at(rs.getString(4));
				bean.setRequest_type(rs.getInt(5));
				bean.setRequest_comment(rs.getString(7));
				bean.setRequest_complete(rs.getBoolean(6));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public boolean isFriend(String user_id1,String user_id2) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM friendinfo WHERE (user_id1 = ? AND user_id2 = ?) OR (user_id1 = ? AND user_id2 = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id1);
			pstmt.setString(2, user_id2);
			pstmt.setString(3, user_id2);
			pstmt.setString(4, user_id1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public boolean isRealFriend(String user_id1,String user_id2) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM friendinfo WHERE ((user_id1 = ? AND user_id2 = ?) OR (user_id1 = ? AND user_id2 = ?)) and friend_type = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id1);
			pstmt.setString(2, user_id2);
			pstmt.setString(3, user_id2);
			pstmt.setString(4, user_id1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public boolean deleteFriend(String user_id1,String user_id2) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM friendinfo WHERE (user_id1 = ? AND user_id2 = ?) OR (user_id1 = ? AND user_id2 = ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id1);
			pstmt.setString(2, user_id2);
			pstmt.setString(3, user_id2);
			pstmt.setString(4, user_id1);
			if(pstmt.executeUpdate() == 1) flag = true;
			
		} catch (Exception e) {
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	public boolean checkDuplicateFriendRequest(String senduserid,String receiveuserid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM friendrequest WHERE ((request_senduserid = ? AND request_receiveuserid = ?) OR (request_senduserid = ? AND request_receiveuserid = ?)) and request_complete = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, senduserid);
			pstmt.setString(2,receiveuserid);
			pstmt.setString(3, receiveuserid);
			pstmt.setString(4, senduserid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				flag = true;
			}
			else flag = isFriend(senduserid,receiveuserid);
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return flag;
	}
	public boolean updateFriendRequestComplete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update friendrequest set request_complete = 1 where request_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
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
	
    public Vector<UserSearchBean> searchUser(String user_search_name){
 	   Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Vector<UserSearchBean> vlist = new Vector<UserSearchBean>();
		try {
			con = pool.getConnection();
			sql = "select u.user_id, u.user_name, p.profile_name from user u join profile p ON u.user_id = p.user_id WHERE u.user_id LIKE ? OR u.user_name LIKE ? OR p.profile_name LIKE ?  order BY u.user_id";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + user_search_name + "%");
			pstmt.setString(2, "%" + user_search_name + "%");
			pstmt.setString(3, "%" + user_search_name + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserSearchBean bean = new UserSearchBean();
				bean.setUser_id(rs.getString(1));
				bean.setUser_name(rs.getString(2));
				bean.setProfile_name(rs.getString(3));
				
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
