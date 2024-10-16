package pjh;

import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import miniroom.UtilMgr;

public class AItemMgr {
	
   
   public static final String ENCTYPE = "UTF-8";
   public static int MAXSIZE = 50*1024*1024;//50mb
    // DBConnectionMgr을 사용하여 데이터베이스 연결
    private DBConnectionMgr pool = DBConnectionMgr.getInstance();

    // 상품 목록을 가져오는 메서드 (검색 기능 포함)
    public Vector<ItemBean> getItemList(String keyField, String keyWord, int start, int cnt) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<ItemBean> itemList = new Vector<ItemBean>();

        try {
            con = pool.getConnection();
            if (keyWord == null || keyWord.trim().equals("")) {
                // 검색이 없는 경우
                sql = "SELECT * FROM item ORDER BY item_num DESC LIMIT ?, ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, start);  // OFFSET
                pstmt.setInt(2, cnt);    // LIMIT
            } else {
                // 검색이 있는 경우
                sql = "SELECT * FROM item WHERE " + keyField + " LIKE ? ORDER BY item_num DESC LIMIT ?, ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "%" + keyWord + "%");
                pstmt.setInt(2, start);  // OFFSET
                pstmt.setInt(3, cnt);    // LIMIT
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                ItemBean item = new ItemBean();
                item.setItem_num(rs.getInt("item_num"));
                item.setItem_name(rs.getString("item_name"));
                item.setItem_image(rs.getString("item_image"));
                item.setItem_type(rs.getString("item_type"));
                item.setItem_price(rs.getInt("item_price"));
                item.setItem_path(rs.getString("item_path"));
                itemList.addElement(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return itemList;
    }



    // 검색어와 검색 필드를 기준으로 한 총 상품 수를 반환하는 메서드 추가
    public int getTotalItemCount(String keyField, String keyWord) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int totalCount = 0;

        try {
            con = pool.getConnection();
            String sql;

            if (keyWord == null || keyWord.trim().equals("")) {
                // 검색어가 없을 때 전체 상품 수를 가져옴
                sql = "SELECT COUNT(*) FROM item";
                pstmt = con.prepareStatement(sql);
            } else {
                // 검색어가 있을 때 조건에 맞는 상품 수를 가져옴
                sql = "SELECT COUNT(*) FROM item WHERE " + keyField + " LIKE ?";
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
    
    public boolean insertProduct(HttpServletRequest req) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        
        try {
            // 서블릿 컨텍스트에서 웹 애플리케이션의 실제 경로를 가져옴
            String saveFolder = req.getServletContext().getRealPath("/miniroom/img");
            System.out.println(saveFolder);

            MultipartRequest multi = new MultipartRequest(req, saveFolder, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
            con = pool.getConnection();
            sql = "INSERT INTO item (item_name, item_image, item_price, item_type, item_path) VALUES (?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, multi.getParameter("item_name"));
            pstmt.setString(2, "../miniroom/img/" + multi.getFilesystemName("item_image"));
            pstmt.setInt(3, UtilMgr.parseInt(multi, "item_price"));
            pstmt.setString(4, multi.getParameter("item_type"));

            if ("음악".equals(multi.getParameter("item_type"))) {
                pstmt.setString(5, "../miniroom/img/" + multi.getFilesystemName("item_path"));
            } else {
                pstmt.setString(5, "../miniroom/img/" + multi.getFilesystemName("item_image"));
            }

            if (pstmt.executeUpdate() == 1) flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
        
    }
    
    
    public boolean updateProduct(HttpServletRequest req) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;

        try {
            // 서블릿 컨텍스트에서 웹 애플리케이션의 실제 경로를 가져옴
            String saveFolder = req.getServletContext().getRealPath("/miniroom/img");

            MultipartRequest multi = new MultipartRequest(req, saveFolder, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
            con = pool.getConnection();
            sql = "UPDATE item SET item_name=?, item_image=?, item_price=?, item_type=?, item_path=? WHERE item_num=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, multi.getParameter("item_name"));
            pstmt.setString(2, "../miniroom/img/" + multi.getFilesystemName("item_image"));
            pstmt.setInt(3, UtilMgr.parseInt(multi, "item_price"));
            pstmt.setString(4, multi.getParameter("item_type"));
            
            if ("음악".equals(multi.getParameter("item_type"))) {
                pstmt.setString(5, "../miniroom/img/" + multi.getFilesystemName("item_path"));
            } else {
                pstmt.setString(5, "../miniroom/img/" + multi.getFilesystemName("item_image"));
            }

            pstmt.setInt(6, UtilMgr.parseInt(multi, "item_num"));

            if (pstmt.executeUpdate() == 1) flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }
}


