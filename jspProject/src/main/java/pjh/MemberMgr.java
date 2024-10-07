package pjh;

import java.net.http.HttpRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;

public class MemberMgr {


   private DBConnectionMgr pool;
   private DefaultMessageService messageService;
  
   public static final String ENCTYPE = "UTF-8";
   public static int MAXSIZE = 300*1024*1024;//50mb
   public MemberMgr() {
      pool = DBConnectionMgr.getInstance();
      // 메시지 서비스 초기화
      messageService = NurigoApp.INSTANCE.initialize("NCS05PHUJJCQP4KS", "GVI8ZIVSAONHOZGGTXDHCDHXGMW6SSSY",
            "https://api.coolsms.co.kr");
   }

   // ID 중복확인
   public boolean checkId(String id) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      boolean flag = false;
      try {
         con = pool.getConnection();
         sql = "select user_id from user where user_id=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         flag = rs.next(); // true이면 중복, false 중복 아님
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return flag;
   }

   // 회원가입
   public boolean insertMember(MemberBean bean) {
       Connection con = null;
       PreparedStatement pstmt1 = null;
       PreparedStatement pstmt2 = null;
       PreparedStatement pstmt3 = null;  
       PreparedStatement pstmt4 = null;  // itemhold 테이블에 저장할 PreparedStatement
       String sql1 = null;
       String sql2 = null;
       String sql3 = null;  
       String sql4 = null;  // itemhold 테이블에 저장할 SQL
       boolean flag = false;

       try {
           con = pool.getConnection();
           con.setAutoCommit(false); // 트랜잭션 시작

           // 현재 날짜를 가져옴
           String userDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
           bean.setUser_date(userDate);  // Bean에 날짜 설정

           // 회원 정보를 user 테이블에 저장
           sql1 = "INSERT INTO user(user_id, user_pwd, user_name, user_birth, user_phone, user_email, user_clover, user_character, user_date) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
           pstmt1 = con.prepareStatement(sql1);
           pstmt1.setString(1, bean.getUser_id());
           pstmt1.setString(2, bean.getUser_pwd());
           pstmt1.setString(3, bean.getUser_name());
           pstmt1.setString(4, bean.getUser_birth());
           pstmt1.setString(5, bean.getUser_phone());
           pstmt1.setString(6, bean.getUser_email());
           pstmt1.setInt(7, bean.getUser_clover());
           pstmt1.setInt(8, 1); // 기본 캐릭터 설정
           pstmt1.setString(9, bean.getUser_date());  // 가입 날짜 추가

           if (pstmt1.executeUpdate() == 1) {
               // 회원가입이 성공하면 miniroom 테이블에도 user_id를 저장
               sql2 = "INSERT INTO miniroom(user_id) VALUES(?)";
               pstmt2 = con.prepareStatement(sql2);
               pstmt2.setString(1, bean.getUser_id());

               if (pstmt2.executeUpdate() == 1) {
                   // profile 테이블에 user_id와 기본값 저장
                   sql3 = "INSERT INTO profile(user_id, profile_name, profile_email, profile_birth, profile_hobby, profile_mbti, profile_content, profile_picture) "
                        + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
                   pstmt3 = con.prepareStatement(sql3);
                   pstmt3.setString(1, bean.getUser_id());
                   pstmt3.setString(2, "임시 닉네임");  // 기본 닉네임
                   pstmt3.setString(3, "example@example.com");  // 기본 이메일
                   pstmt3.setString(4, "2000-01-01");  // 기본 생일
                   pstmt3.setString(5, "임시 취미");  // 기본 취미
                   pstmt3.setString(6, "ENFJ");  // 기본 MBTI
                   pstmt3.setString(7, "기본 상태 메시지");  // 기본 상태 메시지
                   pstmt3.setString(8, "img/default_profile.png");  // 기본 프로필 사진
                   
                   if (pstmt3.executeUpdate() == 1) {
                       // itemhold 테이블에 user_id와 item_num을 각각 1과 6으로 저장
                       sql4 = "INSERT INTO itemhold(user_id, item_num, item_using) VALUES(?, ?, ?), (?, ?, ?)";
                       pstmt4 = con.prepareStatement(sql4);
                       pstmt4.setString(1, bean.getUser_id());
                       pstmt4.setInt(2, 1);  // 임시 item_num 1
                       pstmt4.setInt(3, 0);  // item_using 기본값
                       pstmt4.setString(4, bean.getUser_id());
                       pstmt4.setInt(5, 6);  // 임시 item_num 6
                       pstmt4.setInt(6, 0);  // item_using 기본값
                       
                       if (pstmt4.executeUpdate() == 2) {
                           flag = true;
                           con.commit(); // 트랜잭션 성공 시 커밋
                       } else {
                           con.rollback(); // itemhold 테이블 저장 실패 시 롤백
                           System.out.println("Itemhold 테이블에 저장 실패");
                       }
                   } else {
                       con.rollback(); // profile 테이블 저장 실패 시 롤백
                       System.out.println("Profile 테이블에 저장 실패");
                   }
               } else {
                   con.rollback(); // miniroom 저장 실패 시 롤백
                   System.out.println("Miniroom 테이블에 저장 실패");
               }
           } else {
               con.rollback(); // 회원가입 실패 시 롤백
               System.out.println("User 테이블에 저장 실패");
           }

       } catch (Exception e) {
           e.printStackTrace();
           try {
               if (con != null) {
                   con.rollback(); // 예외 발생 시 롤백
                   System.out.println("롤백 처리됨: " + e.getMessage());
               }
           } catch (SQLException e1) {
               e1.printStackTrace();
           }
       } finally {
           try {
               if (con != null)
                   con.setAutoCommit(true); // 자동 커밋 모드로 복원
           } catch (SQLException e) {
               e.printStackTrace();
           }
           pool.freeConnection(con, pstmt1);
           pool.freeConnection(con, pstmt2);
           pool.freeConnection(con, pstmt3);
           pool.freeConnection(con, pstmt4);  // itemhold 테이블 PreparedStatement 해제
       }
       return flag;
   }





   // 로그인

   public int loginMember(String id, String pwd) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      int mode = 0;
      try {
         if (!checkId(id))
            return mode;
         con = pool.getConnection();
         sql = "select user_id, user_pwd from user where user_id = ? and user_pwd = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, pwd);
         rs = pstmt.executeQuery();
         if (rs.next())
            mode = 2; // 로그인 성공
         else
            mode = 1; // 비밀번호 불일치
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return mode;
   }

   // 회원정보 가져오기
   public MemberBean getMember(String id) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      MemberBean bean = new MemberBean();
      try {
         con = pool.getConnection();
         sql = "select * from user where user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            bean.setUser_id(rs.getString("user_id"));
            bean.setUser_pwd(rs.getString("user_pwd"));
            bean.setUser_name(rs.getString("user_name"));
            bean.setUser_birth(rs.getString("user_birth"));
            bean.setUser_phone(rs.getString("user_phone"));
            bean.setUser_email(rs.getString("user_email"));
            bean.setUser_clover(rs.getInt("user_clover"));
            bean.setUser_character(rs.getInt("user_character"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return bean;
   }

// 인증번호 생성
   public String generateAuthCode() {
      Random rand = new Random();
      StringBuilder authCode = new StringBuilder();
      for (int i = 0; i < 6; i++) { // 6자리 인증번호 생성
         authCode.append(rand.nextInt(10)); // 0~9 숫자 생성
      }
      return authCode.toString();
   }

// 인증번호 전송
   public boolean sendAuthCode(String phoneNumber, String authCode) {
      Message message = new Message();
      message.setFrom("01080131233");
      message.setTo(phoneNumber);
      message.setText("인증번호는 " + authCode + " 입니다.");

      try {
         messageService.send(message); // 인증번호 전송
         return true;
      } catch (NurigoMessageNotReceivedException exception) {
         System.out.println(exception.getFailedMessageList());
         System.out.println(exception.getMessage());
         return false;
      } catch (Exception exception) {
         System.out.println(exception.getMessage());
         return false;
      }
   }

//아이디 찾기 기능: 이름과 전화번호로 아이디 조회
   public String findUserIdByNameAndPhone(String name, String phone) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      String userId = null;
      try {
         con = pool.getConnection();
         sql = "SELECT user_id FROM user WHERE user_name = ? AND user_phone = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, name);
         pstmt.setString(2, phone);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            userId = rs.getString("user_id"); // 아이디 반환
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return userId;
   }

//사용자 검증: 아이디, 이름, 전화번호로 사용자 정보 확인
   public boolean verifyUserForPasswordReset(String id, String name, String phone) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      boolean isValidUser = false;
      try {
         con = pool.getConnection();
         sql = "SELECT * FROM user WHERE user_id = ? AND user_name = ? AND user_phone = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, name);
         pstmt.setString(3, phone);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            isValidUser = true; // 사용자가 존재함
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return isValidUser;
   }

//비밀번호 업데이트
   public boolean updatePassword(String id, String newPassword) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      boolean isUpdated = false;
      try {
         con = pool.getConnection();
         sql = "UPDATE user SET user_pwd = ? WHERE user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, newPassword);
         pstmt.setString(2, id);
         int result = pstmt.executeUpdate();
         if (result == 1) {
            isUpdated = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
      return isUpdated;
   }

//DB에서 사용자 정보를 가져오는 메소드
   public MemberBean getMemberById(String userId) throws Exception {
      MemberBean member = null;
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
         // DBConnectionMgr를 이용하여 DB 연결
         DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
         conn = dbMgr.getConnection();

         // SQL 쿼리: user_id로 사용자 정보 조회
         String sql = "SELECT user_id, user_clover FROM user WHERE user_id = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userId);

         rs = pstmt.executeQuery();

         // 조회 결과가 있을 경우 MemberBean 객체에 저장
         if (rs.next()) {
            member = new MemberBean();
            member.setUser_id(rs.getString("user_id"));
            member.setUser_clover(rs.getInt("user_clover")); // DB에서 가져온 클로버 수 설정
         }
      } catch (SQLException e) {
         e.printStackTrace(); // 오류 출력
      } finally {
         // 자원 해제
         if (rs != null)
            try {
               rs.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         if (pstmt != null)
            try {
               pstmt.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         if (conn != null)
            try {
               conn.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
      }

      return member; // 사용자의 정보를 반환
   }

//결제 후 클로버 업데이트 메소드
   public boolean updateCloverBalance(String userId, int cloverAmount) throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      boolean isUpdated = false;

      try {
         con = pool.getConnection(); // DB 연결
         String sql = "UPDATE user SET user_clover = user_clover + ? WHERE user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, cloverAmount); // 충전할 클로버 양
         pstmt.setString(2, userId);

         int result = pstmt.executeUpdate();
         if (result == 1) {
            isUpdated = true; // 업데이트 성공
         }
      } catch (SQLException e) {
         e.printStackTrace(); // 오류 출력
      } finally {
         pool.freeConnection(con, pstmt);
      }

      return isUpdated;
   }

//특정 사용자의 클로버 잔액 가져오기 메소드
   public int getCloverBalance(String userId) throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int cloverBalance = 0;

      try {
         con = pool.getConnection(); // DB 연결
         String sql = "SELECT user_clover FROM user WHERE user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, userId);

         rs = pstmt.executeQuery();
         if (rs.next()) {
            cloverBalance = rs.getInt("user_clover"); // 클로버 잔액 조회
         }
      } catch (SQLException e) {
         e.printStackTrace(); // 오류 출력
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }

      return cloverBalance;
   }

    public Vector<MemberBean> getUserList(String keyField, String keyWord, int start, int cnt) {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql = null;
           Vector<MemberBean> vlist = new Vector<MemberBean>();

           try {
               con = pool.getConnection();
               if (keyWord == null || keyWord.trim().equals("")) {
                   // 검색이 없는 경우
                   sql = "SELECT * FROM user ORDER BY user_id DESC LIMIT ?, ?";
                   pstmt = con.prepareStatement(sql);
                   pstmt.setInt(1, start);  // OFFSET
                   pstmt.setInt(2, cnt);    // LIMIT
               } else {
                   // 검색이 있는 경우
                   sql = "SELECT * FROM user WHERE " + keyField + " LIKE ? ORDER BY user_id DESC LIMIT ?, ?";
                   pstmt = con.prepareStatement(sql);
                   pstmt.setString(1, "%" + keyWord + "%");
                   pstmt.setInt(2, start);  // OFFSET
                   pstmt.setInt(3, cnt);    // LIMIT
               }

               rs = pstmt.executeQuery();
               while (rs.next()) {
                  MemberBean bean = new MemberBean();
               bean.setUser_id(rs.getString(1));
               bean.setUser_pwd(rs.getString(2));
               bean.setUser_name(rs.getString(3));
               bean.setUser_birth(rs.getString(4));
               bean.setUser_phone(rs.getString(5));
               bean.setUser_email(rs.getString(6));
               bean.setUser_clover(rs.getInt(7));
               bean.setUser_character(rs.getInt(8));
                   vlist.addElement(bean);
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return vlist;
       }



       // 검색어와 검색 필드를 기준으로 한 총 상품 수를 반환하는 메서드 추가
       public int getTotalUserCount(String keyField, String keyWord) {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           int totalCount = 0;

           try {
               con = pool.getConnection();
               String sql;

               if (keyWord == null || keyWord.trim().equals("")) {
                   // 검색어가 없을 때 전체 상품 수를 가져옴
                   sql = "SELECT COUNT(*) FROM user";
                   pstmt = con.prepareStatement(sql);
               } else {
                   // 검색어가 있을 때 조건에 맞는 상품 수를 가져옴
                   sql = "SELECT COUNT(*) FROM user WHERE " + keyField + " LIKE ?";
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
    // 페이지 소유자별 방문자 수 업데이트 (유니크 방문자)
       public void updateVisitorCount(String pageOwnerId, String visitorId, HttpServletResponse response) {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql;
           String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

           try {
               con = pool.getConnection();

               // 오늘의 방문자 수를 조회
               sql = "SELECT * FROM visitCount WHERE DATE(visit_date) = CURDATE() AND page_owner_id = ? AND visitor_id = ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, pageOwnerId);
               pstmt.setString(2, visitorId);
               rs = pstmt.executeQuery();

               if (!rs.next()) {
                   // 방문 기록이 없으면 레코드 삽입
                   sql = "INSERT INTO visitCount (visit_date, visit_count, page_owner_id, visitor_id) VALUES (now(), 1, ?, ?)";
                   pstmt = con.prepareStatement(sql);
                   pstmt.setString(1, pageOwnerId);
                   pstmt.setString(2, visitorId);
                   pstmt.executeUpdate();

                   // 방문 기록이 성공하면 유니크 방문자 쿠키 설정 (하루 동안 유지)
                   javax.servlet.http.Cookie uniqueVisitorCookie = new javax.servlet.http.Cookie("uniqueVisitor_" + pageOwnerId, "visited");
                   uniqueVisitorCookie.setMaxAge(60 * 60 * 24);  // 쿠키 유효기간 하루
                   response.addCookie(uniqueVisitorCookie);  // response 객체를 통해 쿠키를 클라이언트에 추가
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }
       }



       // 페이지 소유자별 오늘의 방문자 수 조회
       public int getTodayVisitorCount(String pageOwnerId) {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql;
           String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
           int todayCount = 0;

           try {
               con = pool.getConnection();

               sql = "SELECT SUM(visit_count) AS today_count FROM visitCount WHERE visit_date like ? AND page_owner_id = ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, today+'%');
               pstmt.setString(2, pageOwnerId);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   todayCount = rs.getInt("today_count");
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return todayCount;
       }

       // 페이지 소유자별 총 방문자 수 조회
       public int getTotalVisitorCount(String pageOwnerId) {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql;
           int totalCount = 0;

           try {
               con = pool.getConnection();

               sql = "SELECT SUM(visit_count) AS total_count FROM visitCount WHERE page_owner_id = ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, pageOwnerId);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   totalCount = rs.getInt("total_count");
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return totalCount;
       }
    // 오늘의 전체 접속 횟수 조회
       public int getTodayVisitorCountForAll() {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql;
           int todayCount = 0;

           try {
               con = pool.getConnection();

               // visit_date의 날짜가 오늘인 모든 방문자의 총 방문 횟수를 계산
               sql = "SELECT SUM(visit_count) AS today_count FROM visitCount WHERE DATE(visit_date) = CURDATE()";
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   todayCount = rs.getInt("today_count");
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return todayCount;
       }



    // 전체 방문자 수 조회
       public int getTotalVisitorCountForAll() {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           String sql;
           int totalCount = 0;

           try {
               con = pool.getConnection();

               // 전체 방문자 수의 총합을 계산
               sql = "SELECT SUM(visit_count) AS total_count FROM visitCount";
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   totalCount = rs.getInt("total_count");
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return totalCount;
       }

    // 월별 방문자 수 가져오기
       public Map<String, Integer> getMonthlyVisitorCount() throws Exception {
           Map<String, Integer> monthlyVisitorCount = new LinkedHashMap<>();
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           
           String sql = "SELECT DATE_FORMAT(visit_date, '%m월') AS month, SUM(visit_count) AS count FROM visitcount GROUP BY month";
           
           try {
               con = pool.getConnection();
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();
               
               // 결과를 Map에 넣기
               while (rs.next()) {
                   monthlyVisitorCount.put(rs.getString("month"), rs.getInt("count"));
               }
           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }
           
           return monthlyVisitorCount;
       }

       // 시간대별 방문자 수 가져오기
       public Map<String, Integer> getHourlyVisitorCount() throws Exception {
           Map<String, Integer> hourlyVisitorCount = new LinkedHashMap<>();
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;

           // 현재 시간을 가져옴
           LocalDateTime now = LocalDateTime.now();

           // SQL 쿼리: 최근 6시간의 방문자 수를 가져옴
           String sql = "SELECT DATE_FORMAT(visit_date, '%H') AS hour, SUM(visit_count) AS count " +
                        "FROM visitcount " +
                        "WHERE visit_date >= DATE_SUB(NOW(), INTERVAL 6 HOUR) " +
                        "GROUP BY hour ORDER BY hour ASC";

           try {
               con = pool.getConnection();
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();

               // 최근 6시간에 대한 방문자 수를 Map에 저장
               while (rs.next()) {
                   hourlyVisitorCount.put(rs.getString("hour"), rs.getInt("count"));
               }

               // 현재 시간을 기준으로 6시간을 저장 (기록 없는 경우 0으로 채움)
               for (int i = 5; i >= 0; i--) {
                   String hourLabel = now.minusHours(i).format(DateTimeFormatter.ofPattern("HH"));
                   hourlyVisitorCount.putIfAbsent(hourLabel, 0);
               }

           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return hourlyVisitorCount;
       }




       // 가상의 DB 데이터 조회 함수 예시
       private Map<String, Integer> getMonthlyDataFromDB1() {
           // 실제 DB 쿼리 구현
           return new HashMap<>(); // 가상의 DB 데이터 반환
       }

       private Map<String, Integer> getHourlyDataFromDB1() {
           // 실제 DB 쿼리 구현
           return new HashMap<>(); // 가상의 DB 데이터 반환
       }
       
    // 5일간의 신규 가입자 수를 반환하는 메서드 추가
       public Map<String, Integer> getDailyNewMembersCount() throws Exception {
           Map<String, Integer> dailyNewMembersCount = new LinkedHashMap<>();
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;

           String sql = "SELECT DATE(user_date) AS reg_date, COUNT(*) AS count FROM user " +
                        "WHERE user_date >= DATE_SUB(CURDATE(), INTERVAL 5 DAY) " +
                        "GROUP BY reg_date ORDER BY reg_date ASC";

           try {
               con = pool.getConnection();
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();

               // 결과를 Map에 넣기
               while (rs.next()) {
                   dailyNewMembersCount.put(rs.getString("reg_date"), rs.getInt("count"));
               }

               // 5일 전부터 오늘까지 날짜를 저장 (기록 없는 경우 0으로 채움)
               for (int i = 5; i >= 0; i--) {
                   String dateLabel = java.time.LocalDate.now().minusDays(i).toString();
                   dailyNewMembersCount.putIfAbsent(dateLabel, 0);
               }

           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return dailyNewMembersCount;
       }
       
    // 총 가입자 수를 반환하는 메서드 추가
       public int getTotalMemberCount() throws Exception {
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;
           int totalMembers = 0;

           try {
               con = pool.getConnection();
               String sql = "SELECT COUNT(*) AS total FROM user";
               pstmt = con.prepareStatement(sql);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   totalMembers = rs.getInt("total"); // 총 회원 수 반환
               }
           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return totalMembers;
       }
       
       //프로필 업데이트 
       public boolean updateProfile(MultipartRequest multi, String user_id, String profilePicturePath) throws Exception {
    	    Connection con = null;
    	    PreparedStatement pstmt = null;
    	    String sql = null;
    	    boolean isUpdated = false;

    	    // 상대 경로 설정
    	    String saveFolder = "/miniroom/img";  // 이미지가 저장될 기본 폴더

    	    try {
    	        con = pool.getConnection();

    	        // 이미지 파일 경로가 존재하지 않는 경우
    	        if (profilePicturePath == null || multi.getFilesystemName("profile_picture") == null) {
    	            sql = "UPDATE profile SET profile_name = ?, profile_email = ?, profile_birth = ?, profile_hobby = ?, profile_mbti = ?, profile_content = ? WHERE user_id = ?";
    	            pstmt = con.prepareStatement(sql);
    	            pstmt.setString(1, multi.getParameter("profile_name"));
    	            pstmt.setString(2, multi.getParameter("profile_email"));
    	            pstmt.setString(3, multi.getParameter("profile_birth"));
    	            pstmt.setString(4, multi.getParameter("profile_hobby"));
    	            pstmt.setString(5, multi.getParameter("profile_mbti"));
    	            pstmt.setString(6, multi.getParameter("profile_content"));
    	            pstmt.setString(7, user_id);
    	        } else {
    	            // 이미지 파일 저장 경로를 상대 경로로 저장
    	            String fileName = multi.getFilesystemName("profile_picture");
    	            String relativeImagePath = saveFolder + "/" + fileName;

    	            sql = "UPDATE profile SET profile_name = ?, profile_email = ?, profile_birth = ?, profile_hobby = ?, profile_mbti = ?, profile_content = ?, profile_picture = ? WHERE user_id = ?";
    	            pstmt = con.prepareStatement(sql);
    	            pstmt.setString(1, multi.getParameter("profile_name"));
    	            pstmt.setString(2, multi.getParameter("profile_email"));
    	            pstmt.setString(3, multi.getParameter("profile_birth"));
    	            pstmt.setString(4, multi.getParameter("profile_hobby"));
    	            pstmt.setString(5, multi.getParameter("profile_mbti"));
    	            pstmt.setString(6, multi.getParameter("profile_content"));
    	            pstmt.setString(7, relativeImagePath); // 상대 경로로 저장
    	            pstmt.setString(8, user_id);
    	        }

    	        int result = pstmt.executeUpdate();
    	        if (result == 1) {
    	            isUpdated = true;
    	        }
    	    } catch (SQLException e) {
    	        e.printStackTrace();
    	    } finally {
    	        pool.freeConnection(con, pstmt);
    	    }

    	    return isUpdated;
    	}

       
       public ProfileBean getProfileByUserId(String userId) throws Exception {
           ProfileBean profile = null;
           Connection con = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;

           try {
               con = pool.getConnection();
               String sql = "SELECT * FROM profile WHERE user_id = ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, userId);
               rs = pstmt.executeQuery();

               if (rs.next()) {
                   profile = new ProfileBean();
                   profile.setUser_id(rs.getString("user_id"));
                   profile.setProfile_name(rs.getString("profile_name"));
                   profile.setProfile_email(rs.getString("profile_email"));
                   profile.setProfile_birth(rs.getString("profile_birth"));
                   profile.setProfile_hobby(rs.getString("profile_hobby"));
                   profile.setProfile_mbti(rs.getString("profile_mbti"));
                   profile.setProfile_content(rs.getString("profile_content"));
                   profile.setProfile_picture(rs.getString("profile_picture"));
               }
           } catch (SQLException e) {
               e.printStackTrace();
               throw new Exception("프로필 정보를 불러오는 중 오류가 발생했습니다.");
           } finally {
               pool.freeConnection(con, pstmt, rs);
           }

           return profile;
       }

       

   }
   

