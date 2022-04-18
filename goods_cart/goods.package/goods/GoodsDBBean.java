package goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDBBean {
	private static GoodsDBBean instance = new GoodsDBBean();
	
	// UserDBBean ��ü �����ϴ� �޼��� - 0418 ����
	public static GoodsDBBean getInstance() {
		return instance;
	}
	
	// db�� �����ϴ� �޼��� - 0418 ����
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// ��ٱ��ϸ� db�� �����ϴ� �޼��� (�ۼ���) - 0418 ����
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
			
			System.out.println("�߰� ����");
		} catch(Exception e) {
			System.out.println("�߰� ����");
			e.printStackTrace();
		}
		
		if(pstmt!=null) pstmt.close();

		return re;
	}
	
	// product_number ��ġ�ϴ� goods�� ������ ������ �޼��� - 0418 ����
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
