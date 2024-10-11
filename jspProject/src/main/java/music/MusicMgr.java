package music;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import board.BoardFolderBean;

public class MusicMgr {
	private DBConnectionMgr pool;
	
	public MusicMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//메인음악에 전체 음악리스트 가져오기
	public Vector<MusicBean> getMusicList(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<MusicBean> vlist = new Vector<MusicBean>();
	    try {
	        con = pool.getConnection();
	        // SQL문에서 item_type이 "음악"인 조건을 추가
	        sql = "SELECT i.item_name, i.item_path " +
	              "FROM itemhold ih " +
	              "JOIN item i ON ih.item_num = i.item_num " +
	              "WHERE ih.user_id = ? AND i.item_type = '음악'";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id); 
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));  
	            bean.setItem_path(rs.getString("item_path"));  // item_path 필드로 수정
	            vlist.add(bean); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist; 
	}
	
	//플레이리스트 포함 해당노래에 대한 정보 모두 지우기
	public void deleteMusicByUserIdAndItemName(String user_id, String item_name) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();

	        // item 테이블에서 item_name을 통해 item_num 조회
	        sql = "SELECT item_num FROM item WHERE item_name = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, item_name);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int item_num = rs.getInt("item_num");

	            // itemhold 테이블에서 user_id와 item_num에 해당하는 행을 삭제
	            sql = "DELETE FROM itemhold WHERE user_id = ? AND item_num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            pstmt.setInt(2, item_num);
	            pstmt.executeUpdate();  // itemhold에서 삭제

	            // PreparedStatement 객체를 다시 초기화하기 위해 기존 pstmt를 닫음
	            pstmt.close();

	            // music 테이블에서 user_id와 item_num에 해당하는 모든 행을 삭제
	            sql = "DELETE FROM music WHERE user_id = ? AND item_num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            pstmt.setInt(2, item_num);
	            int rowsAffected = pstmt.executeUpdate();  // music 테이블에서 삭제

	            if (rowsAffected > 0) {
	                System.out.println("음악이 성공적으로 삭제되었습니다.");
	            } else {
	                System.out.println("music 테이블에서 해당하는 항목이 없습니다.");
	            }
	        } else {
	            System.out.println("해당하는 item_name이 존재하지 않습니다.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) pool.freeConnection(con);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

	
	//플레이리스트의 노래만 지우기
	public void deleteMusicFromPlaylist(String user_id, String item_name, String playlist) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();

	        // item 테이블에서 item_name을 통해 item_num 조회
	        sql = "SELECT item_num FROM item WHERE item_name = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, item_name);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int item_num = rs.getInt("item_num");

	            // PreparedStatement 객체를 다시 초기화하기 위해 기존 pstmt를 닫음
	            pstmt.close();

	            // music 테이블에서 user_id, playlist, item_num이 일치하는 행 삭제
	            sql = "DELETE FROM music WHERE user_id = ? AND playlist = ? AND item_num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            pstmt.setString(2, playlist);
	            pstmt.setInt(3, item_num);

	            // 쿼리 실행
	            int rowsAffected = pstmt.executeUpdate();
	            if (rowsAffected > 0) {
	                System.out.println("플레이리스트에서 음악이 성공적으로 삭제되었습니다.");
	            } else {
	                System.out.println("해당하는 항목이 없습니다.");
	            }
	        } else {
	            System.out.println("해당하는 item_name이 존재하지 않습니다.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) pool.freeConnection(con);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

	
	//해당 유저의 플레이 리스트를 가져옴
	public Vector<String> getUserPlaylists(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<String> playlists = new Vector<String>();
	    try {
	        con = pool.getConnection();
	        // 중복된 플레이리스트를 제외하고 가져오는 SQL 쿼리
	        sql = "SELECT DISTINCT playlist " +
	              "FROM music " +
	              "WHERE user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            playlists.add(rs.getString("playlist"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return playlists;
	}
	
	public Vector<MusicBean> getMusicListByPlaylist(String user_id, String playlist) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<MusicBean> vlist = new Vector<MusicBean>();
	    try {
	        con = pool.getConnection();
	        // SQL문에서 특정 user_id와 playlist에 해당하는 음악만 가져옴
	        String sql = "SELECT i.item_name, i.item_path " +
	                     "FROM music ih " +
	                     "JOIN item i ON ih.item_num = i.item_num " +
	                     "WHERE ih.user_id = ? AND ih.playlist = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.setString(2, playlist);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));
	            bean.setItem_path(rs.getString("item_path"));
	            vlist.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist;
	}
	
	//인기순 정렬
	public Vector<MusicBean> getPopularMusicList() {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<MusicBean> vlist = new Vector<MusicBean>();
	    try {
	        con = pool.getConnection();
	        // SQL 쿼리: '음악' 타입의 아이템을 가져오고 사용자 수 기준으로 내림차순 정렬
	        String sql = "SELECT i.item_name, COUNT(ih.user_id) AS user_count " +
	                     "FROM item i " +
	                     "JOIN itemhold ih ON i.item_num = ih.item_num " +
	                     "WHERE i.item_type = '음악' " +
	                     "GROUP BY ih.item_num " +
	                     "ORDER BY COUNT(ih.user_id) DESC";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));
	            bean.setUserCount(rs.getInt("user_count"));  // user_count 값을 설정
	            vlist.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist;
	}

	//플레이리스트에 노래 추가
	public void addMusicToPlaylist(String playlist, String item_name, String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int item_num = -1;

	    try {
	        con = pool.getConnection();

	        // 1. item 테이블에서 item_name에 해당하는 item_num을 찾음
	        sql = "SELECT item_num FROM item WHERE item_name = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, item_name);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            item_num = rs.getInt("item_num");  // item_num을 가져옴
	        }

	        rs.close();
	        pstmt.close();

	        if (item_num == -1) {
	            throw new Exception("해당 item_name에 대한 item_num을 찾을 수 없습니다.");
	        }

	        // 2. music 테이블에 user_id, playlist, item_num을 추가
	        sql = "INSERT INTO music (user_id, playlist, item_num) VALUES (?, ?, ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.setString(2, playlist);
	        pstmt.setInt(3, item_num);

	        int result = pstmt.executeUpdate();

	        if (result > 0) {
	            System.out.println("음악이 성공적으로 플레이리스트에 추가되었습니다.");
	        } else {
	            System.out.println("음악 추가에 실패했습니다.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	}
	
	
	
	
	
	
	
	
	public boolean addFolder(MusicBean folder) {
		Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO music (user_id, playlist) VALUES (?,?)";
        boolean result = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, folder.getUser_id());
            pstmt.setString(2, folder.getPlaylist());
            int count = pstmt.executeUpdate();
            result = (count > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return result;
	}
	
	public boolean deleteFolder(String userId, String playlist) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "DELETE FROM music WHERE user_id = ? AND playlist = ?";
	    boolean result = false;

	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, userId);      // 첫 번째 인자: user_id
	        pstmt.setString(2, playlist);    // 두 번째 인자: playlist
	        int count = pstmt.executeUpdate();
	        result = (count > 0);            // 삭제된 행이 있으면 true 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return result;  // 삭제 성공 여부 반환
	}

	




	public Vector<MusicBean> getUsedItemsByUser(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<MusicBean> vlist = new Vector<MusicBean>();
	    try {
	        con = pool.getConnection();
	        // itemhold 테이블과 item 테이블을 JOIN하여 item_using이 1인 항목 가져오기
	        String sql = "SELECT i.item_name, i.item_path " +
	                     "FROM itemhold ih " +
	                     "JOIN item i ON ih.item_num = i.item_num " +
	                     "WHERE ih.user_id = ? AND ih.item_using = 1";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id); // user_id를 매개변수로 설정
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            MusicBean bean = new MusicBean();
	            bean.setItem_name(rs.getString("item_name"));
	            bean.setItem_path(rs.getString("item_path"));
	            vlist.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist;
	}

	
	
	
	
	
	public void updateSingleItemUsage(String user_id, String item_path) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();
	        
	        // 1. item_path에 해당하는 item_num 조회
	        sql = "SELECT item_num FROM item WHERE item_path = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, item_path);
	        rs = pstmt.executeQuery();

	        int item_num = -1; // 조회된 item_num을 저장할 변수
	        
	        if (rs.next()) {
	            item_num = rs.getInt("item_num");
	        }

	        rs.close();
	        pstmt.close();

	        if (item_num != -1) {
	            // 2. 조회된 item_num의 item_using 값을 1로 업데이트
	            sql = "UPDATE itemhold SET item_using = 1 WHERE user_id = ? AND item_num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            pstmt.setInt(2, item_num);
	            pstmt.executeUpdate();
	            pstmt.close();
	        } else {
	            System.out.println("해당 경로에 일치하는 아이템이 없습니다.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) pool.freeConnection(con);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}


	
	public void resetAllItemUsage(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        con = pool.getConnection();

	        // 1. 해당 사용자의 모든 item_using을 0으로 업데이트
	        sql = "UPDATE itemhold SET item_using = 0 WHERE user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.executeUpdate();

	        pstmt.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) pool.freeConnection(con);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}


	

}

