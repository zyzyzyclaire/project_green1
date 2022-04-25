package buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;
import cart.CartDBBean;
import goods.GoodsBean;
import goods.GoodsDBBean;

public class UserOrderDetailDBBean {
	private static UserOrderDetailDBBean instance = new UserOrderDetailDBBean();
	
	public static UserOrderDetailDBBean getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Connection conn = null;
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
		return conn;
	}
	
	// userOrder_detail db에 저장하는 메서드 - 0422 근지
	public int insertUserOrderDetail(UserOrderDetailBean userOrderDetail) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// order_detail_number를 세팅하기 위해 -0425 근지
			query = "select max(order_detail_number) from userOrder_detail";
			pstmt = conn.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				number = rs.getInt(1)+1;
			} else {
				number=1;
			}
			
			query = "insert into userOrder_detail(order_detail_number,order_number,product_number,product_count,product_price,order_detail_status)"
					+ " values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, number);
			pstmt.setString(2, userOrderDetail.getOrder_number());
			pstmt.setInt(3, userOrderDetail.getProduct_number());
			pstmt.setInt(4, userOrderDetail.getProduct_count());
			pstmt.setInt(5, userOrderDetail.getProduct_price());
			pstmt.setString(6, "입금 대기");
			pstmt.executeUpdate();
			
			// 주문 상품 재고 줄이는 쿼리	-0422근지
			query = "Update product set product_stock=product_stock-? where product_number=? ";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, userOrderDetail.getProduct_count());
			pstmt.setInt(2, userOrderDetail.getProduct_number());
			pstmt.executeUpdate();
			
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
	
	// userOrder_detail 배열을 db에 저장하는 메서드 - 0422 근지
	public int insertUserOrderDetailArray(String[] cart_num_arr, String order_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// 배열 크기만큼 저장	-0425근지
			for (int i = 0; i < cart_num_arr.length; i++) {
				int cart_num = Integer.parseInt(cart_num_arr[i]);
				CartDBBean cart_db = CartDBBean.getInstance();
				CartBean cart = cart_db.getCart_one(cart_num);
				
				GoodsDBBean goods_db = GoodsDBBean.getInstance();
				GoodsBean goods = goods_db.getGoods(cart.getProduct_number());
				
				int product_price = cart.getProduct_count()*goods.getProduct_price();
				
				// order_detail_number를 세팅하기 위해 -0425 근지
				query = "select max(order_detail_number) from userOrder_detail";
				pstmt = conn.prepareStatement(query);
				
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					number = rs.getInt(1)+1;
				} else {
					number=1;
				}
				
				query = "insert into userOrder_detail(order_detail_number,order_number,product_number,product_count,product_price,order_detail_status)"
						+ " values(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(query);
				
				
				pstmt.setInt(1, number);
				pstmt.setString(2, order_number);
				pstmt.setInt(3, cart.getProduct_number());
				pstmt.setInt(4, cart.getProduct_count());
				pstmt.setInt(5, product_price);
				pstmt.setString(6, "입금 대기");
				pstmt.executeUpdate();
				
				// 주문 상품 재고 줄이는 쿼리	-0422근지
				query = "Update product set product_stock=product_stock-? where product_number=? ";
				pstmt = conn.prepareStatement(query);
				
				pstmt.setInt(1, cart.getProduct_count());
				pstmt.setInt(2, cart.getProduct_number());
				pstmt.executeUpdate();
				
				// 구매한 상품 장바구니에서 삭제하는 쿼리	-0425근지
				query = "delete from cart where cart_number=? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, cart_num);
				pstmt.executeUpdate();
			}
			
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
		
}
