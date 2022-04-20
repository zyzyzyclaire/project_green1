package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;
import cart.CartDBBean;

public class ProductDBBean {
	
private static ProductDBBean instance = new ProductDBBean();
	
	// cartDBBean 객체 생성하는 메서드 - 0418 근지
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// db와 연결하는 메서드 - 0418 근지
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	//전체 상품 리스트 목록
	public ArrayList<ProductBean> getProductlist() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("들어옴?");
		String query = "select product_number"
							+ ",category_code"
							+ ",product_name"
							+ ",product_price"
							+ ",product_stock"
							+ ",product_desc"
							+ ",product_date"
							+ ",product_hits"
							+ " from product";
		
		ArrayList<ProductBean> ProductArr = new ArrayList<ProductBean>();
		ProductBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
		
			//System.out.println("여기까지는들어옴?");
			while (rs.next()) {
				product = new ProductBean();
				product.setProduct_number(rs.getInt("product_number"));
				product.setCategory_code(rs.getString("category_code"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_desc(rs.getString("product_desc"));
				product.setProduct_date(rs.getTimestamp("product_date"));
				product.setProduct_hits(rs.getInt("product_hits"));
				//System.out.println(rs.getInt("product_number"));
				
				ProductArr.add(product);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductArr;
	}
	
	//상품이미지 리스트 목록   최신 date 값받아서 조회시켜야함 10개만
	public ArrayList<ProductBean> getProductimg(ArrayList<ProductBean> ProductlistArr) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select file_number"
							+ ",product_number"
							+ ",orgin_file_name"
							+ ",stored_file_name"
							+ ",stored_thumbnail"
							+ ",delegate_thumbnail"
							+ ",file_size"
							+ ",create_date"
							+ ",delete_check"
							+ " from product_imagefile"
							+ " where product_number = ?";
		
		ArrayList<ProductBean> ProductimgArr = new ArrayList<ProductBean>();
		ProductBean product = null;
		
		try {
			conn = getConnection();
			for (int j = 0; j < ProductlistArr.size(); j++) {
				pstmt = conn.prepareStatement(query);
				//System.out.println("상품번호는 "+ ProductlistArr.get(j).getProduct_number());
				int number = ProductlistArr.get(j).getProduct_number();
				pstmt.setInt(1, number);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					product = new ProductBean();
					product.setProduct_number(rs.getInt("file_number"));
					product.setProduct_number(rs.getInt("product_number"));
					product.setOrgin_file_name(rs.getString("orgin_file_name"));
					product.setStored_file_name(rs.getString("stored_file_name"));
					product.setStored_thumbnail(rs.getString("stored_thumbnail"));
					product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
					product.setFile_size(rs.getInt("file_size"));
					product.setCreate_date(rs.getTimestamp("create_date"));
					product.setDelete_check(rs.getString("delete_check"));
					ProductimgArr.add(product);
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return ProductimgArr;
	}
	
	
	
	//상품catehory 리스트 목록
	public ArrayList<ProductBean> getCategoryProductList(String category_code) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ "	where category_code = ?";
			
			ArrayList<ProductBean> ProductArr = new ArrayList<ProductBean>();
			ProductBean product = null;
			
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, category_code);
				rs = pstmt.executeQuery();
			
				//System.out.println("여기까지는들어옴?");
				while (rs.next()) {
					product = new ProductBean();
					product.setProduct_number(rs.getInt("product_number"));
					product.setCategory_code(rs.getString("category_code"));
					product.setProduct_name(rs.getString("product_name"));
					product.setProduct_price(rs.getInt("product_price"));
					product.setProduct_stock(rs.getInt("product_stock"));
					product.setProduct_desc(rs.getString("product_desc"));
					product.setProduct_date(rs.getTimestamp("product_date")); 
					product.setProduct_hits(rs.getInt("product_hits"));
					//System.out.println(rs.getInt("product_number"));
					
					ProductArr.add(product);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return ProductArr;
		}
	
	
}	
