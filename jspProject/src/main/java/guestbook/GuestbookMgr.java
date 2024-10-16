package guestbook;

import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GuestbookMgr {
    private DBConnectionMgr pool;

 // 작성자의 프로필 정보를 가져오기 위해 profileMgr 인스턴스 생성
    private GuestbookprofileMgr profileMgr = new GuestbookprofileMgr();
    
    public GuestbookMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // Guestbook entry addition
    public int addGuestbookEntry(GuestbookBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "INSERT INTO guestbook (guestbook_secret, owner_id, writer_id, guestbook_content, written_at) VALUES (?, ?, ?, ?, NOW())";
        int generatedId = 0; // 생성된 guestbookNum을 저장할 변수

        try {
            con = pool.getConnection();
            // 생성된 키를 가져오기 위해 RETURN_GENERATED_KEYS를 사용
            pstmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            
         // guestbook_secret를 int로 변환하여 저장
          
            pstmt.setString(1, bean.getGuestbookSecret());
            pstmt.setString(2, bean.getOwnerId());
            pstmt.setString(3, bean.getWriterId());
            pstmt.setString(4, bean.getGuestbookContent());
            pstmt.executeUpdate();

            // 생성된 guestbookNum을 가져옴
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1); // 첫 번째 열에 생성된 키가 들어감
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return generatedId; // 생성된 guestbookNum 반환
    }

   
    // Retrieve guestbook entries for a specific owner
    public ArrayList<GuestbookBean> getGuestbookEntries(String ownerId,int startIndex, int entriesPerPage) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<GuestbookBean> list = new ArrayList<>();
        String sql = "SELECT * FROM guestbook WHERE owner_id = ? ORDER BY written_at DESC LIMIT ?,?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, ownerId);
            pstmt.setInt(2, startIndex);
            pstmt.setInt(3, entriesPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                GuestbookBean bean = new GuestbookBean();
                bean.setGuestbookNum(rs.getInt("guestbook_num"));
                bean.setGuestbookSecret(rs.getString("guestbook_secret"));
                bean.setOwnerId(rs.getString("owner_id"));
                bean.setWriterId(rs.getString("writer_id"));
                bean.setGuestbookContent(rs.getString("guestbook_content"));
                bean.setWrittenAt(rs.getTimestamp("written_at"));
                bean.setModifiedAt(rs.getTimestamp("modified_at"));
                
                GuestbookprofileBean profile = profileMgr.getProfileByUserId(bean.getWriterId());
                if (profile != null) {
                    bean.setProfileName(profile.getProfileName());
                    bean.setProfilePicture(profile.getProfilePicture());
                }
                list.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return list;
    }

    // Delete guestbook entry
 // Delete guestbook entry and its replies
    public boolean deleteGuestbookEntry(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        GuestbookanswerMgr answerMgr = new GuestbookanswerMgr(); // 답글 매니저 인스턴스 생성

        // 먼저 해당 방명록의 모든 답글 삭제
        answerMgr.deleteAllAnswersForGuestbook(guestbookNum);
        
        String sql = "DELETE FROM guestbook WHERE guestbook_num = ?";
        
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);
            int count = pstmt.executeUpdate();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return false;
    }


    // Update guestbook entry
    public boolean updateGuestbookEntry(int guestbookNum, String content) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE guestbook SET guestbook_content = ?, modified_at = NOW() WHERE guestbook_num = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, content);
            pstmt.setInt(2, guestbookNum);
            int count = pstmt.executeUpdate();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return false;
    }
 // GuestbookMgr 클래스 내부에 추가
    public Timestamp getWrittenAt(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Timestamp writtenAt = null;
        String sql = "SELECT written_at FROM guestbook WHERE guestbook_num = ?";
        
        try {
            con = pool.getConnection(); // 데이터베이스 연결 가져오기
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                writtenAt = rs.getTimestamp("written_at");
                
                System.out.println("written_at for guestbookNum " + guestbookNum + ": " + writtenAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return writtenAt; // 가져온 written_at 반환
    }
    
    public int getTotalPages(String ownerId) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		float count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from guestbook where owner_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ownerId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return (int)Math.ceil(count/3);
    }
    public GuestbookBean getGuestbookEntry(int guestbook_num) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        GuestbookBean bean = new GuestbookBean();
        String sql = "SELECT * FROM guestbook WHERE guestbook_num = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbook_num);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                
                bean.setGuestbookNum(rs.getInt("guestbook_num"));
                bean.setGuestbookSecret(rs.getString("guestbook_secret"));
                bean.setOwnerId(rs.getString("owner_id"));
                bean.setWriterId(rs.getString("writer_id"));
                bean.setGuestbookContent(rs.getString("guestbook_content"));
                bean.setWrittenAt(rs.getTimestamp("written_at"));
                bean.setModifiedAt(rs.getTimestamp("modified_at"));
                
                GuestbookprofileBean profile = profileMgr.getProfileByUserId(bean.getWriterId());
                if (profile != null) {
                    bean.setProfileName(profile.getProfileName());
                    bean.setProfilePicture(profile.getProfilePicture());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return bean;
    }
    
}
