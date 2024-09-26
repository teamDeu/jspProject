package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class GuestbookMgr {
    private DBConnectionMgr pool;

    // 생성자
    public GuestbookMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // 방명록 작성 메서드
    public boolean writeGuestbook(GuestbookBean g) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO guestbook (guestbook_secret, owner_id, writer_id, guestbook_content, written_at, modified_at) "
                + "VALUES (?, ?, ?, ?, NOW(), NULL)"; // 현재 시간 NOW()로 변경;
        boolean isWritten = false;

        try { 
            con = pool.getConnection(); // Connection 객체를 pool에서 가져옴
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, g.getGuestbookSecret()); // 비밀글 여부
            pstmt.setString(2, g.getOwnerId()); // 방명록 주인의 아이디
            pstmt.setString(3, g.getWriterId()); // 글쓴이의 아이디
            pstmt.setString(4, g.getGuestbookContent()); // 방명록 내용

            // 디버깅용 출력 구문
            System.out.println(pstmt.toString()); // SQL 구문을 출력
            System.out.println("guestbookSecret: " + g.getGuestbookSecret());
            System.out.println("ownerId: " + g.getOwnerId());
            System.out.println("writerId: " + g.getWriterId());
            System.out.println("guestbookContent: " + g.getGuestbookContent());

            
            int count = pstmt.executeUpdate(); // 실행

            if (count > 0) {
                isWritten = true; // 성공적으로 삽입된 경우 true
            }
        } catch (Exception e) {
        	System.out.println("Error in writeGuestbook: " + e.getMessage());
            e.printStackTrace(); // 에러 로그 출력
        } finally {
            pool.freeConnection(con, pstmt); // 연결 종료
        }

        return isWritten;
    }
    
    // 방명록 삭제 메서드
    public boolean deleteGuestbook(int guestbookNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM guestbook WHERE guestbook_num = ?";
        boolean isDeleted = false;

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, guestbookNum);

            int count = pstmt.executeUpdate(); // 삭제된 행의 수를 반환
            if (count > 0) {
                isDeleted = true; // 삭제 성공
            }
        } catch (Exception e) {
            e.printStackTrace(); // 에러 출력
        } finally {
            pool.freeConnection(con, pstmt); // 리소스 해제
        }

        return isDeleted;
    }

    // 특정 사용자의 방명록 항목을 가져오는 메서드
    public List<GuestbookBean> getGuestbookEntriesByOwner(String ownerId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<GuestbookBean> guestbookList = new ArrayList<>();
        String sql = "SELECT * FROM guestbook WHERE owner_id = ? ORDER BY written_at DESC";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, ownerId); // 방명록 주인 ID로 필터링
            rs = pstmt.executeQuery();

            while (rs.next()) {
                GuestbookBean guestbook = new GuestbookBean();
                guestbook.setGuestbookNum(rs.getInt("guestbook_num"));
                guestbook.setGuestbookSecret(rs.getString("guestbook_secret"));
                guestbook.setOwnerId(rs.getString("owner_id"));
                guestbook.setWriterId(rs.getString("writer_id"));
                guestbook.setGuestbookContent(rs.getString("guestbook_content"));
                guestbook.setWrittenAt(rs.getTimestamp("written_at"));
                guestbook.setModifiedAt(rs.getTimestamp("modified_at"));
                guestbookList.add(guestbook);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs); // 리소스 해제
        }

        return guestbookList; // 방명록 목록 반환
    }
}
