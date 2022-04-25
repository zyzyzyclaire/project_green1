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
	
	// userOrder_detail db�� �����ϴ� �޼��� - 0422 ����
	public int insertUserOrderDetail(UserOrderDetailBean userOrderDetail) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// order_detail_number�� �����ϱ� ���� -0425 ����
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
			pstmt.setString(6, "�Ա� ���");
			pstmt.executeUpdate();
			
			// �ֹ� ��ǰ ��� ���̴� ����	-0422����
			query = "Update product set product_stock=product_stock-? where product_number=? ";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, userOrderDetail.getProduct_count());
			pstmt.setInt(2, userOrderDetail.getProduct_number());
			pstmt.executeUpdate();
			
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
	
	// userOrder_detail �迭�� db�� �����ϴ� �޼��� - 0422 ����
	public int insertUserOrderDetailArray(String[] cart_num_arr, String order_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "";
		int re = -1;
		int number;
		
		try {
			conn = getConnection();
			
			// �迭 ũ�⸸ŭ ����	-0425����
			for (int i = 0; i < cart_num_arr.length; i++) {
				int cart_num = Integer.parseInt(cart_num_arr[i]);
				CartDBBean cart_db = CartDBBean.getInstance();
				CartBean cart = cart_db.getCart_one(cart_num);
				
				GoodsDBBean goods_db = GoodsDBBean.getInstance();
				GoodsBean goods = goods_db.getGoods(cart.getProduct_number());
				
				int product_price = cart.getProduct_count()*goods.getProduct_price();
				
				// order_detail_number�� �����ϱ� ���� -0425 ����
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
				pstmt.setString(6, "�Ա� ���");
				pstmt.executeUpdate();
				
				// �ֹ� ��ǰ ��� ���̴� ����	-0422����
				query = "Update product set product_stock=product_stock-? where product_number=? ";
				pstmt = conn.prepareStatement(query);
				
				pstmt.setInt(1, cart.getProduct_count());
				pstmt.setInt(2, cart.getProduct_number());
				pstmt.executeUpdate();
				
				// ������ ��ǰ ��ٱ��Ͽ��� �����ϴ� ����	-0425����
				query = "delete from cart where cart_number=? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, cart_num);
				pstmt.executeUpdate();
			}
			
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
		
}