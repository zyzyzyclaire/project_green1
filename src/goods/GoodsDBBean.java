package goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDBBean {
	private static GoodsDBBean instance = new GoodsDBBean();
	 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
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
	
	// goods�� db�� �����ϴ� �޼��� - 0418 ����
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
	
	
	// product_number ��ġ�ϴ� goods�� ������ ������ �޼��� - 0418 ����
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
	
	//�Ʒ��ʺ��� �����Ѱ�@@@@@@@@@@@@@@@@@@@@@@@@@@@@// �����ϸ� �ٹٲ���ؼ� ��������
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//��ǰcategory_code ��ǰ ���� ����Ʈ
	public ArrayList<GoodsBean> getCategoryProductList(String category_code) throws Exception {
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
		
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, category_code);
			rs = pstmt.executeQuery();
		
			//System.out.println("��������µ���?");
			while (rs.next()) {
				product = new GoodsBean();
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
	
	//�˻� 
	public ArrayList<GoodsBean> getsearch(String searchtext) throws Exception {
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
				+ " from product" + 
						" where REGEXP_LIKE(product_name,?) or REGEXP_LIKE(product_desc,?)";
		
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, searchtext);
			
			pstmt.setString(2, searchtext);
			
			rs = pstmt.executeQuery();
			
			//System.out.println("��������µ���?");
			while (rs.next()) {
			
				product = new GoodsBean();
				product.setProduct_number(rs.getInt("product_number"));
				product.setCategory_code(rs.getString("category_code"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_desc(rs.getString("product_desc"));
				product.setProduct_date(rs.getTimestamp("product_date"));
				product.setProduct_hits(rs.getInt("product_hits"));
				/*
				 * System.out.print(rs.getString("product_name"));
				 * System.out.println(rs.getString("product_desc"));
				 */
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
	
	
	//��ü��ǰ����Ʈ��ȯ
	public ArrayList<GoodsBean> getProductlist() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		System.out.println("����?");
		String query = "select product_number"
							+ ",category_code"
							+ ",product_name"
							+ ",product_price"
							+ ",product_stock"
							+ ",product_desc"
							+ ",product_date"
							+ ",product_hits"
							+ " from product";
		
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
		
			//System.out.println("��������µ���?");
			while (rs.next()) {
				product = new GoodsBean();
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
	
	//��ǰ �̹��� ����Ʈ  �������� ������ǰ ����Ʈ ��
	public ArrayList<GoodsBean> getProductimg(ArrayList<GoodsBean> ProductlistArr) throws Exception {
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
//		System.out.println(ProductlistArr.size());
		ArrayList<GoodsBean> ProductimgArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			for (int j = 0; j < ProductlistArr.size(); j++) {
				pstmt = conn.prepareStatement(query);
				//System.out.println("��ǰ��ȣ�� "+ ProductlistArr.get(j).getProduct_number());
				int number = ProductlistArr.get(j).getProduct_number();
				pstmt.setInt(1, number);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					product = new GoodsBean();
					
					if(rs.getString("stored_file_name") != null){
						product.setFile_number(rs.getInt("file_number"));
						product.setProduct_number(rs.getInt("product_number"));
						product.setOrgin_file_name(rs.getString("orgin_file_name"));
						product.setStored_file_name(rs.getString("stored_file_name"));
						product.setStored_thumbnail(rs.getString("stored_thumbnail"));
						product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
						product.setFile_size(rs.getInt("file_size"));
						product.setCreate_date(rs.getTimestamp("create_date"));
						product.setDelete_check(rs.getString("delete_check"));
						ProductimgArr.add(product);
					}else {
						product.setFile_number(rs.getInt("file_number"));
						product.setProduct_number(rs.getInt("product_number"));
						product.setOrgin_file_name("�̹�������");
						product.setStored_file_name("�̹�������");
						product.setStored_thumbnail("�̹�������");
						product.setDelegate_thumbnail("�̹�������");
						product.setFile_size(0);
						product.setCreate_date(null);
						product.setDelete_check("�̹�������");
						ProductimgArr.add(product);
						
					}
//					System.out.println("");
					
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
	
	
	//��ǰ����ϴµ� ��ȯ���� ��ǰ ��ȣ�� MAX ��
	public int insertProduct(GoodsBean pBean) throws Exception { 
	  	Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;
	   
			// ��� ���
	
			int re = -1;
			int count = 0;
	  try { 
		  conn = getConnection();
		  String query = "select MAX(product_number) from product";
		 
		  pstmt = conn.prepareStatement(query);
		  rs = pstmt.executeQuery();
		 
		  if(rs.next()) {
			  count =   rs.getInt(1);
		  }else {
			  count = 0;
		  }
		  
		  count=count+1;
		 System.out.println("@@@@@@@count@>>"+count);
		   query = "insert into product(product_number,category_code,product_name,product_price,product_stock"
					+ ",product_desc,product_date) "
					+ " values (?,?,?,?,?,?,?)";
	  pstmt = conn.prepareStatement(query);
	  pstmt.setInt(1, count) ;
	  pstmt.setString(2, pBean.getCategory_code());
	  pstmt.setString(3, pBean.getProduct_name());
	  pstmt.setInt(4, pBean.getProduct_price());
	  pstmt.setInt(5, pBean.getProduct_stock());
	  pstmt.setString(6, pBean.getProduct_desc());
	  pstmt.setTimestamp(7, timestamp);
	
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
	  
	  return count; 
	 }
	
	
	
	//��ǰ�̹������  insertProduct()�� ���̽���
		public int insertProductimg(GoodsBean pBean) throws Exception { 
		  	Connection conn = null;
			PreparedStatement pstmt = null;
			 ResultSet rs = null;
		    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			// ��� ���
	
			int re =-1;
	  try { 
		  conn = getConnection();
		
		
	
			String query = "insert into product_imagefile(file_number,product_number"
					+ ",orgin_file_name"
					+ ",stored_file_name"
					+ ",create_date) values (?,?,?,?,?)";
		  pstmt = conn.prepareStatement(query);
		  pstmt.setInt(1, pBean.getFile_number()) ;
		  pstmt.setInt(2, pBean.getProduct_number());
		  pstmt.setString(3, pBean.getOrgin_file_name());
		  pstmt.setString(4, pBean.getStored_file_name());
		  pstmt.setTimestamp(5, timestamp);
		
	
		  re = pstmt.executeUpdate(); 
		  
		  
		  System.out.println("�̹������߰� ����"); 
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
