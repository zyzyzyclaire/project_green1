package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	
	// cartDBBean 객체 생성하는 메서드 - 0418 근지
	public static CartDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0418 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// 장바구니를 db에 저장하는 메서드 - 0418 근지
	public int insertCart(String user_id, int product_number, int product_count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number = 0;
		int count = 0;
		
		try {
			conn = getConnection();
			
			// cart_number를 세팅하기 위해 -0418 근지
			query = "select max(cart_number) from cart";
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number=1;
			}
			
			// product_count를 세팅+카드에 담기 -0418 근지
			query = "select product_count from cart where user_id=? and product_number=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 개수만 추가될 때 -0418근지
				count = rs.getInt(1)+product_count;
				
				query = "update cart set product_count=? where user_id=? and product_number=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, count);
				pstmt.setString(2, user_id);
				pstmt.setInt(3, product_number);
				
				re = pstmt.executeUpdate();
				re = 1;
				
			} else {	//  새 상품을 추가한 것일 때 -0418근지
				count = product_count;
			
				query = "insert into cart"
						+ "(cart_number, user_id, product_number, product_count)"
						+ "values(?,?,?,?)";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, number);
				pstmt.setString(2, user_id);
				pstmt.setInt(3, product_number);
				pstmt.setInt(4, product_count);
				
				re = pstmt.executeUpdate();
				re = 1;
			}
			
			System.out.println("추가 성공");
		} catch(Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return re;
	}
	
	// user_id와 일치하는 cart의 정보를 얻어오는 메서드 - 0418 근지
	public ArrayList<CartBean> getCart(String user_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select product_number, product_count from cart where user_id=?";
		
		ArrayList<CartBean> cartArr = new ArrayList<CartBean>();
		CartBean cart = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				cart = new CartBean();
				cart.setProduct_number(rs.getInt("product_number"));
				cart.setProduct_count(rs.getInt("product_count"));
				cartArr.add(cart);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return cartArr;
	}
	
}