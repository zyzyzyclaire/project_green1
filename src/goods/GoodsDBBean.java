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
	
	// goods를 db에 저장하는 메서드 - 0418 근지
	public int insertGoods(GoodsBean goods) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into product values(?,?,?,?,?,?,?,?)";
		int re = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
		    pstmt.setInt(1, goods.getProduct_number());
		    pstmt.setString(2, goods.getCategory_code());
		    pstmt.setString(3, goods.getProduct_name());
		    pstmt.setInt(4, goods.getProduct_price());
		    pstmt.setInt(5, goods.getProduct_stock());
		    pstmt.setString(6, goods.getProduct_desc());
		    pstmt.setTimestamp(7, goods.getProduct_date());
		    pstmt.setInt(8, goods.getProduct_hits());
			
			re = pstmt.executeUpdate();
			re = 1;
			
			System.out.println("추가 성공");
		} catch(Exception e) {
			System.out.println("추가 실패");
			e.printStackTrace();
		} finally {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		

		return re;
	}
	
	// product_number 일치하는 goods의 정보를 얻어오는 메서드 - 0418 근지
	public GoodsBean getGoods(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from product where product_number=?";
		GoodsBean goods = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return goods;
	}

}
