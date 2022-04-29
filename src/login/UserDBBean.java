package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDBBean {
	private static UserDBBean instance = new UserDBBean();
	
	// UserDBBean ��ü �����ϴ� �޼��� - 0415 ����
	public static UserDBBean getInstance() {
		return instance;
	}
	
	// db�� �����ϴ� �޼��� - 0415 ����
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// register���� user�� �޾� db�� �����ϴ� �޼��� - 0415 ����
	public int insertUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into user_table(user_id,user_pwd,user_name,user_phone,user_email,user_addr,user_grade)"
					 + " values(?,?,?,?,?,?,?)";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUser_id());
			pstmt.setString(2, user.getUser_pwd());
			pstmt.setString(3, user.getUser_name());
			pstmt.setString(4, user.getUser_phone());
			pstmt.setString(5, user.getUser_email());
			pstmt.setString(6, user.getUser_addr());
			pstmt.setString(7, "B");
			
			re = pstmt.executeUpdate();
			re = 1;
			
			System.out.println("�߰� ����");
		} catch(Exception e) {
			System.out.println("�߰� ����");
			e.printStackTrace();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}

		return re;
	}
	
	public int confirmUserId(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// �Ű������� ���� user_id�� �ֱ� - 0415 ����
			rs = pstmt.executeQuery();
			
			// �ߺ��� user_id�� �ִ��� �Ǵ��ϱ� ���� if�� - 0415 ����
			if (rs.next()) {
				re = 1;
			} else {
				re = -1;
			}
		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// ����� ������ ����ϴ� �޼��� - 0415 ����
	public int userCheck(String user_id, String user_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		ResultSet rs = null;
		String query = "select user_pwd from user_table where user_id=?";
		
		
		int re = -1;
		String db_pwd;
		
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// �Ű������� ���� user_id�� �ֱ� - 0415 ����
			rs = pstmt.executeQuery();
			
			
			if (rs.next()) {	// ���̵� ��ġ�ϴ� �ο� ���� - 0415 ����
				db_pwd = rs.getString("user_pwd");
				
				if (db_pwd.equals(user_pwd)) {	// �н����嵵 ��ġ - 0415 ����
					re = 1;
				
				} else {	// �н����尡 ����ġ - 0415 ����
					re = 0;
					
				}
			} else {	// �ش� ���̵� �������� ���� - 0415 ����
				re = -1;
			}
		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// ���̵� ��ġ�ϴ� ����� ������ ������ �޼��� - 0415 ����
	public UserBean getUser(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		UserBean user = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	// �Ű������� ���� user_id�� �ֱ� - 0415 ����
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// ���������� ��ġ�ϴ� �ο� ���� - 0415 ����
				user = new UserBean();
				user.setUser_id(rs.getString("user_id"));
				user.setUser_pwd(rs.getString("user_pwd"));
				user.setUser_name(rs.getString("user_name"));
				user.setUser_phone(rs.getString("user_phone"));
				user.setUser_email(rs.getString("user_email"));
				user.setUser_addr(rs.getString("user_addr"));
				user.setUser_grade(rs.getString("user_grade"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user;
	}
	
	// Ż����� ����� ������ ������ �޼��� - 0415 ����
	public String bannedUser(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from user_table where user_id=?";
		UserBean user = null;
		String pwd = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user_id);	
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	
				user = new UserBean();
				user.setUser_id(rs.getString("user_id"));
				user.setUser_pwd(rs.getString("user_pwd"));
			}
			
			pwd = user.getUser_pwd();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return pwd;
	}
	
	// ȸ�� ���� ���̺� ���� Ư�� ���� ���� �����ϴ� �޼��� - 0415 ����
	public int updateUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;

		String query = "update user_table set user_pwd=?, user_email=?, user_phone=?, user_addr=? where user_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user.getUser_pwd());
			pstmt.setString(2,user.getUser_email());
			pstmt.setString(3,user.getUser_phone());
			pstmt.setString(4,user.getUser_addr());
			pstmt.setString(5,user.getUser_id());
			re = pstmt.executeUpdate();
			
			System.out.println("���� ����");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("���� ����");
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// ȸ�� Ż�� �޼��� - 0415 ����
	public int outUser(String user_id,String user_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;
		
		
	
		int check = userCheck(user_id,user_pwd);
		
		String query = "delete from cart where user_id=?";
		
	
		
		if(check!=0) {
			try {
				conn = getConnection();
			
				pstmt = conn.prepareStatement(query);
			
				pstmt.setString(1,user_id);
			
				re = pstmt.executeUpdate();
				
				
			
				query = "delete from user_table where user_id=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1,user_id);
				re = pstmt.executeUpdate();
				
				
				System.out.println("���� ����");
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("���� ����");
			} finally {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
		}else {
			re=0;
		}
		
		return re;
	}
	
	// �̸����� ���� ����� ���̵� ã�� �޼��� - 0416 ����
	public String tryToFindId(String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select user_id from user_table where user_email=?";
		
		String user_id = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,email);	// �Ű������� ���� email�� �ֱ� - 0416 ����
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// �̸����� ��ġ�ϴ� �ο� ���� - 0416 ����
				user_id = rs.getString("user_id");
			} else {	// �ش� �̸����� �������� ���� - 0416 ����
				user_id = null;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user_id;
	}
	
	// ���̵�, �̸����� ���� ����� �н����带 ã�� �޼��� - 0416 ����
	public String tryToFinPwd(String id, String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select user_pwd from user_table where user_id=? and user_email=?";
		
		String user_pwd = "";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,id);	// �Ű������� ���� id�� �ֱ� - 0416 ����
			pstmt.setString(2,email);	// �Ű������� ���� email�� �ֱ� - 0416 ����
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// ��ġ�ϴ� �ο� ���� - 0416 ����
				user_pwd = rs.getString("user_pwd");
			} else {	// �������� ���� - 0416 ����
				user_pwd = null;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return user_pwd;
	}
	
	//�α����� ȸ���� ���������� Ȯ���ϴ� �޼��� - 0419 ����
	public boolean isAdmin(String user_id) throws SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;

		String SQL = "SELECT user_grade FROM user_table WHERE user_id = ?";
		boolean isAdmin = false;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isAdmin = (rs.getString("user_grade").equals("C") );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}

		return isAdmin;
	}
	
	// Ż���Ų ȸ���� Ȯ���ϴ� �޼��� - 0422 ���� 
		public UserBean defineUserId(String u_id) throws SQLException {
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection conn = null;
			
			System.out.println("????"+u_id);
			String sql = "SELECT user_id, user_grade FROM user_table WHERE user_id = ?"; 
			UserBean user = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					String id = rs.getString("user_id");
					user = new UserBean(id);
					user.setUser_grade(rs.getString("user_grade"));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			
			return user;
		}
		
		public int deleteUser(String delete_uid) throws SQLException {
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection conn = null;
			String sql = "UPDATE user_table SET user_pwd = '-1', user_name = '-Ż��', user_phone = '000-0000-0000', "
					+ "user_email = 'unknown', user_addr='unknown', user_grade = 'D' WHERE user_id = ?";
			int isDelete = -1;

			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, delete_uid);
				isDelete = pstmt.executeUpdate();
				System.out.println("@@@@@@@ Ż�� ó��(" + isDelete + "): " + delete_uid);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}

			return isDelete;
		}
		
		// ȸ�� ����� �ҷ����� �޼��� - 0422 ����
		public ArrayList<UserBean> listUsers() throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<UserBean> uList = new ArrayList<UserBean>();
			String sql ="SELECT "
					+ "u.user_id, user_name, user_phone, user_email, user_addr, user_grade, o_count "
					+ "FROM user_table u, (SELECT user_id, COUNT(*) AS o_count FROM user_order GROUP BY user_id) o "
					+ "WHERE u.user_id = o.user_id(+) ORDER BY user_grade DESC, u.user_id DESC";
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					String userId = rs.getString("user_id");
					String userName = rs.getString("user_name");
					String userPhone = rs.getString("user_phone");
					String userEmail = rs.getString("user_email");
					String userAddr = rs.getString("user_addr");
					String userGrade = rs.getString("user_grade");
					int userPurchase = rs.getInt("o_count");

					UserBean user = new UserBean( //
							userId, //
							"-1", // userPassword,
							userName, //
							userPhone, //
							userEmail, //
							userAddr, //
							userGrade // 
							);
					
					user.setUserPurchase(userPurchase);

					uList.add(user);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}

			return uList;
		}
}

