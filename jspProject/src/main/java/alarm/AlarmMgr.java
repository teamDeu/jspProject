package alarm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AlarmMgr {

		private DBConnectionMgr pool;
		
		public AlarmMgr() {
			pool = DBConnectionMgr.getInstance();
		}
		
		public Vector<AlarmBean> getAllAlarm(String id){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			Vector<AlarmBean> vlist = new Vector<AlarmBean>();
			try {
				con = pool.getConnection();
				sql = "select * from alarm where alarm_user_id = ? and alarm_delete = 0 order by alarm_num desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					AlarmBean bean = new AlarmBean();
					bean.setAlarm_num(rs.getInt(1));
					bean.setAlarm_user_id(rs.getString(2));
					bean.setAlarm_type(rs.getString(3));
					bean.setAlarm_at(rs.getString(4));
					bean.setAlarm_content_num(rs.getInt(5));
					bean.setAlarm_read(rs.getBoolean(6));
					bean.setAlarm_delete(rs.getBoolean(7));
					vlist.add(bean);
				}
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		public boolean insertAlarm(AlarmBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert alarm values(null,?,?,now(),?,0,0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,bean.getAlarm_user_id());
				pstmt.setString(2,bean.getAlarm_type());
				pstmt.setInt(3,bean.getAlarm_content_num());
				
				if(pstmt.executeUpdate() == 1) flag = true;
				} catch (Exception e) {
					e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		public boolean updateReadAlarm(int alarm_num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update alarm set alarm_read = 1 where alarm_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, alarm_num);
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
		
		public boolean deleteAllReadAlarm(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update alarm set alarm_delete = 1 where alarm_user_id = ? and alarm_read = 1";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,id);
				if(pstmt.executeUpdate() == 1) flag = true;
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		public boolean deleteAlarmByContent(String type,int content_num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update alarm set alarm_delete = 1 where alarm_type = ? and alarm_content_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,type);
				pstmt.setInt(2, content_num);
				if(pstmt.executeUpdate() == 1) flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
}
