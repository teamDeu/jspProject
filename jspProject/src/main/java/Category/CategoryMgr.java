package Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import pjh.MemberBean;
import pjh.MemberMgr;

public class CategoryMgr {
    private DBConnectionMgr pool;

    public CategoryMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // Insert Category
    public boolean insertCategory(CategoryBean category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String checkSql = "SELECT COUNT(*) FROM category WHERE user_id = ? AND category_type = ?";
        String sql = "INSERT INTO category (user_id, category_type, category_name, category_secret, category_index) VALUES (?, ?, ?, ?, ?)";

        try {
            conn = pool.getConnection();
            
            System.out.println("Inserting categoryType: " + category.getCategoryType());
            System.out.println("Inserting categoryName: " + category.getCategoryName());
            
            // 중복 체크
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, category.getUserId());
            pstmt.setString(2, category.getCategoryType());
            rs = pstmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                // 중복된 경우 삽입하지 않고 false 반환
                System.out.println("Duplicate category entry found for user_id: " + category.getUserId() + " and category_type: " + category.getCategoryType());
                return false;
            }
            
            // 중복이 없을 경우 삽입
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getUserId());
            pstmt.setString(2, category.getCategoryType());
            pstmt.setString(3, category.getCategoryName());
            pstmt.setInt(4, category.getCategorySecret());

            // category_index를 자동으로 부여 (가장 큰 index 값을 +1)
            pstmt.setInt(5, maxIndex(category.getUserId()) + 1);
            
            int count = pstmt.executeUpdate();
            return count > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs); // Connection 반환
        }
        return false;
    }


    // Retrieve Categories by UserId
    public ArrayList<CategoryBean> getCategoriesByUserId(String userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<CategoryBean> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM category WHERE user_id = ? ORDER BY category_index ASC, created_at ASC";
        try {
            conn = pool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoryBean category = new CategoryBean();
                category.setUserId(rs.getString("user_id"));
                category.setCategoryType(rs.getString("category_type"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategorySecret(rs.getInt("category_secret"));
                category.setCategoryIndex(rs.getInt("category_index"));
                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally { 
            pool.freeConnection(conn, pstmt, rs); // Connection 반환
        }
        return categoryList;
    }


 // Update Category
    public boolean updateCategory(CategoryBean category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean success = false;
        int currentIndex = getIndex(category.getUserId(),category.getCategoryType());
        System.out.println(currentIndex);
        
        String updateSql = "UPDATE category SET category_name = ?, category_secret = ?, category_index = ? WHERE user_id = ? AND category_type = ?";
        if(category.getCategoryIndex() == 1) {
        	return false;
        }
        try {
            conn = pool.getConnection();
            updateIndex(category.getUserId(),category.getCategoryIndex(),currentIndex);
            

            // 카테고리 업데이트 쿼리 실행
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, category.getCategoryName());
            pstmt.setInt(2, category.getCategorySecret());
            pstmt.setInt(3, category.getCategoryIndex());
            pstmt.setString(4, category.getUserId());
            pstmt.setString(5, category.getCategoryType());
            int count = pstmt.executeUpdate();

            System.out.println("Number of rows updated: " + count); // 로그 출력
            success = (count > 0);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs); // Connection 반환
        }
        return success;
    }

    // Delete Category
    public boolean deleteCategory(String userId, String categoryType, String categoryName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM category WHERE user_id = ? AND category_type = ? AND category_name = ?";

        try {
            conn = pool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, categoryType);
            pstmt.setString(3, categoryName);
            int count = pstmt.executeUpdate();

            System.out.println("Number of rows deleted: " + count); // 추가 로그
            return count > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt); // Connection 반환
        }
        return false;
    }


    // 카테고리 리스트
    public List<CategoryBean> getAllCategoriesByUserId(String userId) {
        List<CategoryBean> categoryList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = pool.getConnection();
            // 카테고리를 생성 순서대로 정렬하여 가져오기 (예시: created_at 컬럼을 기준으로 정렬)
            String sql = "SELECT category_type, category_name, category_secret FROM category WHERE user_id = ? ORDER BY category_index ASC, created_at asc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CategoryBean category = new CategoryBean();
                category.setCategoryType(rs.getString("category_type"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategorySecret(rs.getInt("category_secret"));
                categoryList.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }
        
        return categoryList;
    }
    
    public void initCategory(String user_id) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		String[] category = {"홈","프로필","미니룸","게시판","방명록","상점","게임","음악"};
		try {
			con = pool.getConnection();
			sql = "insert category values(?,?,?,0,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			for(int i = 0 ; i < category.length ; i++) {
				pstmt.setString(2,category[i]);
				pstmt.setString(3,category[i]);
				pstmt.setInt(4,i+1);
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    public int maxIndex(String user_id) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int maxIndex = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(category_index) FROM category WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				maxIndex = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxIndex;
    }
    
    public void updateIndex(String user_id,int changeIndex , int currentIndex) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			if(currentIndex > changeIndex) {
				sql = "update category set category_index = category_index + 1 where category_index >= ? and user_id = ? and category_index < ?";
			}
			else if(currentIndex < changeIndex){
				sql = "update category set category_index = category_index -1 where category_index <= ? and user_id = ? and category_index > ?";
			}
			else {
				return;
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, changeIndex);
			pstmt.setString(2, user_id);
			pstmt.setInt(3, currentIndex);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    public int getIndex(String user_id,String category_type) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int index = 0;
		try {
			con = pool.getConnection();
			sql = "select category_index from category where user_id = ? and category_type = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, category_type);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return index;
    }
    public static void main(String[] args) {
		MemberMgr mgr = new MemberMgr();
		Vector<MemberBean> vlist= mgr.getAllUserList();
		for(int i = 0 ; i < vlist.size(); i ++) {
			MemberBean bean = vlist.get(i);
			
		}
		CategoryMgr cMgr = new CategoryMgr();
		cMgr.initCategory("1234");
	}

}
