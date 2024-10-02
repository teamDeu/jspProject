package report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import miniroom.UtilMgr;
import pjh.ItemBean;

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
	
	 public Vector<ReportBean> getReportList(String keyField, String keyWord, int start, int cnt) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String sql = null;
	        Vector<ReportBean> reportList = new Vector<ReportBean>();

	        try {
	            con = pool.getConnection();
	            if (keyWord == null || keyWord.trim().equals("")) {
	                // 검색이 없는 경우
	                sql = "SELECT * FROM report ORDER BY report_num DESC LIMIT ?, ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setInt(1, start);  // OFFSET
	                pstmt.setInt(2, cnt);    // LIMIT
	            } else {
	                // 검색이 있는 경우
	                sql = "SELECT * FROM report WHERE " + keyField + " LIKE ? ORDER BY report_num DESC LIMIT ?, ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setString(1, "%" + keyWord + "%");
	                pstmt.setInt(2, start);  // OFFSET
	                pstmt.setInt(3, cnt);    // LIMIT
	            }
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	ReportBean bean = new ReportBean();
	            	bean.setReport_num(rs.getInt(1));
	            	bean.setReport_senduserid(rs.getString(2));
	            	bean.setReport_receiveuserid(rs.getString(3));
	            	bean.setReport_at(rs.getString(4));
	            	bean.setReport_type(rs.getString(5));
	            	
	            	reportList.add(bean);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt, rs);
	        }

	        return reportList;
	    }



	    // 검색어와 검색 필드를 기준으로 한 총 상품 수를 반환하는 메서드 추가
	    public int getTotalReportCount(String keyField, String keyWord) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int totalCount = 0;

	        try {
	            con = pool.getConnection();
	            String sql;

	            if (keyWord == null || keyWord.trim().equals("")) {
	                // 검색어가 없을 때 전체 상품 수를 가져옴
	                sql = "SELECT COUNT(*) FROM report";
	                pstmt = con.prepareStatement(sql);
	            } else {
	                // 검색어가 있을 때 조건에 맞는 상품 수를 가져옴
	                sql = "SELECT COUNT(*) FROM report WHERE " + keyField + " LIKE ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setString(1, "%" + keyWord + "%");
	            }
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                totalCount = rs.getInt(1);  // 총 상품 수를 가져옴
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt, rs);
	        }

	        return totalCount;  // 총 상품 수 반환
	    }
	    
	    public ReportBean getReportBean(int num) {
	    	Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String sql = null;
	        ReportBean bean = new ReportBean();

	        try {
	            con = pool.getConnection();

	                // 검색이 없는 경우
	                sql = "SELECT * FROM report where report_num = ?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setInt(1, num);
	            
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	
	            	bean.setReport_num(rs.getInt(1));
	            	bean.setReport_senduserid(rs.getString(2));
	            	bean.setReport_receiveuserid(rs.getString(3));
	            	bean.setReport_at(rs.getString(4));
	            	bean.setReport_type(rs.getString(5));
	            	

	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt, rs);
	        }

	        return bean;
	    }
	    public Vector<ChatLogBean> getChatLogByReport(ReportBean report){
	 
	    	Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Vector<ChatLogBean> vlist = new Vector<ChatLogBean>();
			
			String sql = "";
			try {
				con = pool.getConnection();
				sql = "SELECT * FROM chatlog WHERE chatlog_id = ? AND chatlog_at >= ? AND chatlog_at < ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, report.getReport_receiveuserid());
				String[] times = UtilMgr.setTimeRange(report.getReport_at());
				pstmt.setString(2, times[0]);
				pstmt.setString(3, times[1]);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					ChatLogBean bean = new ChatLogBean();
					bean.setChatlog_num(rs.getInt(1));
					bean.setChatlog_id(rs.getString(2));
					bean.setChatlog_content(rs.getString(3));
					bean.setChatlog_at(rs.getString(4));
					vlist.add(bean);
				}
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
	    }
	    public SuspensionBean getSuspension(int num) {
	    	
	    	Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			SuspensionBean bean = new SuspensionBean();
			try {
				con = pool.getConnection();
				sql = "select * from suspension where suspension_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setSuspension_num(rs.getInt(1));
					bean.setSuspension_id(rs.getString(2));
					bean.setSuspension_date(rs.getString(3));
					bean.setSuspension_type(rs.getInt(4));
					bean.setSuspension_reason(rs.getInt(5));
				}
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			
			return bean;
	    }
	    public SuspensionBean isSuspension(String id) {
	    	Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			SuspensionBean bean = new SuspensionBean();
			try {
				con = pool.getConnection();
				sql = "select * from suspension where suspension_id = ? and suspension_date > now() order by suspension_type desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setSuspension_num(rs.getInt(1));
					bean.setSuspension_id(rs.getString(2));
					bean.setSuspension_date(rs.getString(3));
					bean.setSuspension_type(rs.getInt(4));
					bean.setSuspension_reason(rs.getInt(5));
				}
			} catch (Exception e) {
				// TODO: handle exception
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			
			return bean;
	    }
}	
