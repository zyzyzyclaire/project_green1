package goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDBBean {
	private static GoodsDBBean instance = new GoodsDBBean();
	
	// UserDBBean 객체 생성하는 메서드 - 0418 근지
	public static GoodsDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0418 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// 장바구니를 db에 저장하는 메서드 (작성중) - 0418 근지
	public int insertGoods(String product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into cart values(?,?,?,?,?,?,?,?)";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, );
			
			re = pstmt.executeUpdate();
			re = 1;
			
			pstmt.close();
			conn.close();
			
			System.out.println("추가 성공");
		} catch(Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		}
		
		if(pstmt!=null) pstmt.close();

		return re;
	}
	
	// product_number 일치하는 goods의 정보를 얻어오는 메서드 - 0418 근지
	public GoodsBean getGoods(String product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from team_product where product_number=?";
		GoodsBean goods = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				goods = new GoodsBean();
				goods.setProduct_number(rs.getInt("product_number"));
				goods.setCategory_code(rs.getString("category_code"));
				goods.setProduct_name(rs.getString("product_name"));
				goods.setProduct_price(rs.getInt("product_price"));
				goods.setProduct_stock(rs.getInt("product_stock"));
				goods.setProduct_desc(rs.getString("product_desc"));
				goods.setProduct_date(rs.getTimestamp("product_date"));
				goods.setProduct_hits(rs.getInt("product_hits"));
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return goods;
	}
	

}
