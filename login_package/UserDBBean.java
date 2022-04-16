package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		String query = "insert into user_table values(?,?,?,?,?,?)";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUser_id());
			pstmt.setString(2, user.getUser_pwd());
			pstmt.setString(3, user.getUser_name());
			pstmt.setString(4, user.getUser_email());
			pstmt.setString(5, user.getUser_phone());
			pstmt.setString(6, user.getUser_addr());
			
			re = pstmt.executeUpdate();
			re = 1;
			
			pstmt.close();
			conn.close();
			
			System.out.println("�߰� ����");
		} catch(Exception e) {
			System.out.println("�߰� ����");
			e.printStackTrace();
		}
		
		if(pstmt!=null) pstmt.close();

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
		
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
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
		
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
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
				user.setUser_email(rs.getString("user_email"));
				user.setUser_phone(rs.getString("user_phone"));
				user.setUser_addr(rs.getString("user_addr"));
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	// ȸ�� ���� ���̺� ���� Ư�� ���� ���� �����ϴ� �޼��� - 0415 ����
	public int updateUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;

		String query = "update user_table set user_pwd=?, user_email=?, user_addr=? where user_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user.getUser_pwd());
			pstmt.setString(2,user.getUser_email());
			pstmt.setString(3,user.getUser_addr());
			pstmt.setString(4,user.getUser_id());
			re = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			System.out.println("���� ����");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("���� ����");
		}
		return re;
	}
	
	// ȸ�� Ż�� �޼��� - 0415 ����
	public int outUser(UserBean user) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int re = -1;

		String query = "delete from user_table where user_id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,user.getUser_id());
			re = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			System.out.println("���� ����");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("���� ����");
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
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
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
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return user_pwd;
	}
}

