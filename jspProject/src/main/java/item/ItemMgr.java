package item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	public Vector<ItemBean> getMusicItems(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "select * from item where item_type = '음악'";
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
	
	
	public Vector<ItemBean> getCharacterItems(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "select * from item where item_type = '캐릭터'";
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
	public Vector<ItemBean> getBackgroundItems(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ItemBean> vlist = new Vector<ItemBean>();
		try {
			con = pool.getConnection();
			sql = "select * from item where item_type = '배경화면'";
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
	  // 클로버 차감 및 상품 구매 처리 메서드
    public String purchaseItem(String userId, String itemName, int itemPrice, int itemNum) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int userClover = 0;
        String resultMessage = "";

        try {
            conn = pool.getConnection();

            if (conn == null) {
                throw new SQLException("DB 연결 실패");
            }

            // 1. 유저의 현재 클로버 잔액 가져오기
            String sql = "SELECT user_clover FROM user WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                throw new SQLException("유저 데이터를 찾을 수 없습니다.");
            }

            userClover = rs.getInt("user_clover");

            // 2. 클로버 잔액이 충분한지 확인
            if (userClover >= itemPrice) {
                // 3. 클로버 잔액 차감
                sql = "UPDATE user SET user_clover = user_clover - ? WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, itemPrice);
                pstmt.setString(2, userId);
                pstmt.executeUpdate();

                // 4. 구매한 상품을 itemhold 테이블에 저장
                sql = "INSERT INTO itemhold (user_Id, item_num, item_using) VALUES (?, ?, 0)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                pstmt.setInt(2, itemNum);
                pstmt.executeUpdate();

                // 성공 메시지와 남은 클로버 반환
                resultMessage = String.valueOf(userClover - itemPrice);
            } else {
                // 클로버 잔액 부족 시 메시지 반환
                resultMessage = "잔액이 부족합니다.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resultMessage = "서버 오류가 발생했습니다.";
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) pool.freeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return resultMessage;
    }
}

