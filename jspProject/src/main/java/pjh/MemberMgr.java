package pjh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.Vector;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;

public class MemberMgr {

	private DBConnectionMgr pool;
	private DefaultMessageService messageService;

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
		String sql1 = null;
		String sql2 = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			con.setAutoCommit(false); // 트랜잭션 시작

			// 회원 정보를 user 테이블에 저장
			sql1 = "INSERT INTO user(user_id, user_pwd, user_name, user_birth, user_phone, user_email, user_clover, user_character) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt1 = con.prepareStatement(sql1);
			pstmt1.setString(1, bean.getUser_id());
			pstmt1.setString(2, bean.getUser_pwd());
			pstmt1.setString(3, bean.getUser_name());
			pstmt1.setString(4, bean.getUser_birth());
			pstmt1.setString(5, bean.getUser_phone());
			pstmt1.setString(6, bean.getUser_email());
			pstmt1.setInt(7, bean.getUser_clover());
			pstmt1.setInt(8, 1); // 기본 캐릭터 설정

			if (pstmt1.executeUpdate() == 1) {
				// 회원가입이 성공하면 miniroom 테이블에도 user_id를 저장
				sql2 = "INSERT INTO miniroom(user_id) VALUES(?)";
				pstmt2 = con.prepareStatement(sql2);
				pstmt2.setString(1, bean.getUser_id());

				if (pstmt2.executeUpdate() == 1) {
					flag = true;
					con.commit(); // 트랜잭션 성공 시 커밋
				} else {
					con.rollback(); // miniroom 저장 실패 시 롤백
				}
			} else {
				con.rollback(); // 회원가입 실패 시 롤백
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (con != null) {
					con.rollback(); // 예외 발생 시 롤백
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
	 // 방문자 수 업데이트 메서드
	    public boolean updateVisitCount(String pageOwnerId, String visitorId) {
	        Connection con = null;
	        PreparedStatement pstmt1 = null;
	        PreparedStatement pstmt2 = null;
	        boolean flag = false;

	        try {
	            con = pool.getConnection();

	            // 방문자가 페이지 소유자와 다를 경우에만 카운트
	            if (!pageOwnerId.equals(visitorId)) {
	                // 오늘 해당 페이지 소유자에 대한 방문 기록이 있는지 확인
	                String sql1 = "SELECT COUNT(*) FROM visitcount WHERE user_id = ? AND visitor_id = ? AND visit_today = CURDATE()";
	                pstmt1 = con.prepareStatement(sql1);
	                pstmt1.setString(1, pageOwnerId);
	                pstmt1.setString(2, visitorId);
	                ResultSet rs = pstmt1.executeQuery();

	                int count = 0;
	                if (rs.next()) {
	                    count = rs.getInt(1);
	                }

	                // 오늘 방문 기록이 없으면 새로 추가
	                if (count == 0) {
	                    String sql2 = "INSERT INTO visitcount (user_id, visitor_id, visit_today) VALUES (?, ?, CURDATE())";
	                    pstmt2 = con.prepareStatement(sql2);
	                    pstmt2.setString(1, pageOwnerId);
	                    pstmt2.setString(2, visitorId);
	                    int result = pstmt2.executeUpdate();
	                    if (result == 1) {
	                        flag = true; // 성공적으로 업데이트된 경우
	                    }
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt1);
	            pool.freeConnection(con, pstmt2);
	        }

	        return flag;
	    }

	    // 방문자 수 정보 가져오기
	    public VisitCountBean getVisitCount(String pageOwnerId) {
	        Connection con = null;
	        PreparedStatement pstmt1 = null;
	        PreparedStatement pstmt2 = null;
	        ResultSet rs = null;
	        VisitCountBean visitCountBean = new VisitCountBean();

	        try {
	            con = pool.getConnection();

	            // 오늘 해당 페이지 소유자에 대한 방문자 수 가져오기
	            String sql1 = "SELECT COUNT(*) FROM visitcount WHERE user_id = ? AND visit_today = CURDATE()";
	            pstmt1 = con.prepareStatement(sql1);
	            pstmt1.setString(1, pageOwnerId);
	            rs = pstmt1.executeQuery();
	            if (rs.next()) {
	                visitCountBean.setVisit_today(rs.getInt(1)); // 오늘 방문자 수 저장
	            }

	            // 해당 페이지 소유자의 전체 방문자 수 가져오기
	            String sql2 = "SELECT COUNT(*) FROM visitcount WHERE user_id = ?";
	            pstmt2 = con.prepareStatement(sql2);
	            pstmt2.setString(1, pageOwnerId);
	            rs = pstmt2.executeQuery();
	            if (rs.next()) {
	                visitCountBean.setVisit_all(rs.getInt(1)); // 전체 방문자 수 저장
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            pool.freeConnection(con, pstmt1, rs);
	            pool.freeConnection(con, pstmt2);
	        }

	        return visitCountBean;
	    }
	}
	

