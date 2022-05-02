package goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import cart.CartBean;
import cart.CartDBBean;



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
	
	// product_number ��ġ�ϴ� goods�� �̹����� ������ �޼��� - 0429 ����
	public GoodsBean getGoodsImg(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from product_imagefile where product_number=?";
		GoodsBean goods = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				goods = new GoodsBean();
				goods.setFile_number(rs.getInt("file_number"));
				goods.setProduct_number(rs.getInt("product_number"));
				goods.setOrgin_file_name(rs.getString("orgin_file_name"));
				goods.setStored_file_name(rs.getString("stored_file_name"));
				goods.setStored_thumbnail(rs.getString("stored_thumbnail"));
				goods.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
				goods.setFile_size(rs.getInt("file_size"));
				goods.setCreate_date(rs.getTimestamp("create_date"));
				goods.setDelete_check(rs.getString("delete_check"));
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
					
	public int deleteGoods(int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		int re = -1;
		try {
			conn = getConnection();
			query = " delete from product where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			re =pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
				try {
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return re;
	}
		
		
		
		//�����̹���                       //�̹����Ѱ��϶� �̹��������Ϸ��� ���̸� �Ѱ� false �ΰ�
	public int updateGoods(GoodsBean goods, boolean stored_thumbnail, boolean imgs) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String query = null;
		int re = -1;
		try {
			conn = getConnection();
			
			if(stored_thumbnail == false) {
				 query = "update product" + 
						" set Product_name = ?"
						+ ",Product_price = ?"
						+ ",Product_desc = ?"
						+ ",Category_code  = ?" + 
						"where product_number = ?";
				pstmt = conn.prepareStatement(query);
			    pstmt.setString(1, goods.getProduct_name());
			    pstmt.setInt(2, goods.getProduct_price());
			    pstmt.setString(3, goods.getProduct_desc());
			    pstmt.setString(4, goods.getCategory_code());
			    pstmt.setInt(5, goods.getProduct_number());
				re = pstmt.executeUpdate();
				
				query = "select file_number,stored_file_name"
						+ " from product_imagefile where product_number = ?";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, goods.getProduct_number());
				rs = pstmt.executeQuery();
				
				re =-1;
				int count = 0;
				while(rs.next()) {  
					count ++;
					int file_number = rs.getInt("file_number");
					if(goods.getStored_file_name() !=null) {
						if(rs.getString("stored_file_name")!= null){
							query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_file_name = ?" + 
									" where file_number = ?";
							pstmt = conn.prepareStatement(query);
							pstmt.setString(1, goods.getOrgin_file_name());
							pstmt.setString(2, goods.getStored_file_name());
							pstmt.setInt(3, file_number);
							re = pstmt.executeUpdate();
						}
					}
					
					 if(imgs == false && count ==2) {
						  query = " delete from product_imagefile where stored_thumbnail is not null and product_number = ?";
							pstmt = conn.prepareStatement(query);
							pstmt.setInt(1, goods.getProduct_number());
							 pstmt.executeUpdate();
					  }
				}
				
			
				  if(re == -1) {   //��ǥ�̹�����������ó�� 
					  query = "select file_number " +
							  		" from product_imagefile where product_number = ?"
							  		+ " order by file_number"; 
					  pstmt = conn.prepareStatement(query); 
					  pstmt.setInt(1, goods.getProduct_number());
					  rs = pstmt.executeQuery();
					
					  if(rs.next()) {
						  query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_file_name = ?" + 
									" where file_number = ?";
						  pstmt = conn.prepareStatement(query);
						  pstmt.setString(1, goods.getOrgin_file_name());
						  pstmt.setString(2, goods.getStored_file_name());
						  pstmt.setInt(3, rs.getInt("file_number"));
						  re = pstmt.executeUpdate();
					  }
					  
				  }
			}else {
				//System.out.println("��ǰ�̹������ΰ��Դϴ� DBB �ȿ��ִ� if ��");
				
				query = "select file_number,orgin_file_name,stored_file_name,stored_thumbnail"
						+ " from product_imagefile where product_number = ?"
						+ " order by file_number";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, goods.getProduct_number());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					if(goods.getStored_thumbnail() != null) {
						
						if(rs.getString("stored_thumbnail") != null) {
							query = "update product_imagefile" + 
									" set orgin_file_name = ?, stored_thumbnail = ?" + 
									" where file_number = ?"
									+ " order by file_number";
							  pstmt = conn.prepareStatement(query);
							  pstmt.setString(1, goods.getOrgin_file_name() );
							  pstmt.setString(2, goods.getStored_thumbnail() );
							  pstmt.setInt(3, rs.getInt("file_number"));
							  re = pstmt.executeUpdate();
						}
					}
					
					
				}
				 //��ǰ stored_thumbnail �̹�������� �߰�
				if(re == -1) {
					
					query = "select MAX(file_number) from product_imagefile";
					 
					  pstmt = conn.prepareStatement(query);
					  rs = pstmt.executeQuery();
					
					  if(rs.next()) {
						   int file_number = rs.getInt(1);
						   file_number = file_number+1;
						
						  query = "insert into product_imagefile(file_number,product_number"
									+ ",orgin_file_name"
									+ ",stored_thumbnail"
									+ ") values (?,?,?,?)";
						  pstmt = conn.prepareStatement(query);
						  pstmt.setInt(1, file_number);
						  pstmt.setInt(2, goods.getProduct_number());
						  pstmt.setString(3, goods.getOrgin_file_name());
						  pstmt.setString(4, goods.getStored_thumbnail());
						  re = pstmt.executeUpdate();
						  
					  }
					
					
				}
				
		}
			 
			
			
//			re = 1;
			
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
	
	/////////////
	
	
	public int insertGoodss(GoodsBean goods, boolean stored_thumbnail) throws Exception { 
	  	Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String query;
		 int product_number = 0;
			// ��� ���
	
			int re = -1;
			int file_number = 0;
	  try { 
		  
		  
		  conn = getConnection();
		  query = "select MAX(product_number) from product";
			 
		  pstmt = conn.prepareStatement(query);
		  rs = pstmt.executeQuery();
		 
		  if(rs.next()) {
			  product_number =   rs.getInt(1);
		  }else {
			  product_number = 0;
		  }
		  
	  		if(stored_thumbnail == false) {

				  product_number=product_number+1;
				
				   query = "insert into product(product_number,category_code,product_name,product_price,product_stock"
							+ ",product_desc,product_date,product_hits,product_ordered_count) "
							+ " values (?,?,?,?,?,?,?,?,?)";
				   
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, product_number) ;
				  pstmt.setString(2, goods.getCategory_code());
				  pstmt.setString(3, goods.getProduct_name());
				  pstmt.setInt(4, goods.getProduct_price());
				  pstmt.setInt(5, goods.getProduct_stock());
				  pstmt.setString(6, goods.getProduct_desc());
				  pstmt.setTimestamp(7, timestamp);
				  pstmt.setInt(8, 0);
				  pstmt.setInt(9, 0);
			
				  re = pstmt.executeUpdate(); 
				  
				  
				  query = "insert into product_imagefile(file_number,product_number"
							+ ",orgin_file_name"
							+ ",stored_file_name"
							+ ",create_date) values (?,?,?,?,?)";
				  
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, product_number) ;
				  pstmt.setInt(2, product_number);
				  pstmt.setString(3, goods.getOrgin_file_name());
				  pstmt.setString(4, goods.getStored_file_name());
				  pstmt.setTimestamp(5, timestamp);
				  re = pstmt.executeUpdate(); 
				  re = 1;
			  }else {
				  
				  if(product_number==0) {
					  product_number = 1;
				  }
				  
				  
				  query = "select MAX(file_number) from product_imagefile";
					 
				  pstmt = conn.prepareStatement(query);
				  rs = pstmt.executeQuery();
				 
				  if(rs.next()) {
					  file_number =   rs.getInt(1);
				  }else {
					  file_number = 0;
				  }
				  file_number=file_number+1;
				  
				  
				   query = "insert into product_imagefile(file_number,product_number"
							+ ",orgin_file_name"
							+ ",stored_thumbnail"
							+ ",create_date) values (?,?,?,?,?)";
				  pstmt = conn.prepareStatement(query);
				  pstmt.setInt(1, file_number) ;
				  pstmt.setInt(2, product_number);
				  pstmt.setString(3, goods.getOrgin_file_name());
				  pstmt.setString(4, goods.getStored_file_name());
				  pstmt.setTimestamp(5, timestamp);
				  
				  re = pstmt.executeUpdate(); 
			  }
		
		  
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

	// ��ǰ�� ��ȸ���� �ø��� �޼���	-0429����
	public void hitUp(int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			query = " update product set product_hits=product_hits+1 where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			pstmt.executeUpdate();
			
			System.out.println("��ȸ��1����");
		}catch (Exception e) {
			System.out.println("��ȸ�������ȵ�");
			e.printStackTrace();
		}finally {
				try {
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}	
	
	// ��ǰ ���Ž� ���� ī��Ʈ�� ������Ű�� �޼���	-0429����
	public void orderedCountUp(int product_count, int product_number) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			query = " update product set product_ordered_count = product_ordered_count + ? where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_count);
			pstmt.setInt(2, product_number);
			pstmt.executeUpdate();
			
			System.out.println("���ż�����");
		}catch (Exception e) {
			System.out.println("���ż������ȵ�");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	
	
	
	// ��ǰ ���Ž� ���� ī��Ʈ�� ������Ű�� �޼���	-0429����
	public void orderedCountUpArray(String[] cart_num_arr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = null;
		try {
			conn = getConnection();
			
			// �迭 ũ�⸸ŭ ����	-0425����
			for (int i = 0; i < cart_num_arr.length; i++) {
				int cart_num = Integer.parseInt(cart_num_arr[i]);
				CartDBBean cart_db = CartDBBean.getInstance();
				CartBean cart = cart_db.getCart_one(cart_num);
				
			query = " update product set product_ordered_count = product_ordered_count + ? where product_number = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cart.getProduct_count());
			pstmt.setInt(2, cart.getProduct_number());
			pstmt.executeUpdate();
			}
			
			System.out.println("���ż�-�迭-����");
		}catch (Exception e) {
			System.out.println("���ż�-�迭-�����ȵ�");
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	
	
	// ���� �ȸ� ������ ��ǰ ������(ī�װ�) -0429����
	public ArrayList<GoodsBean> getCategoryProductList_best(String category_code) throws Exception {
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
							+ "	where category_code = ?"
							+ " order by product_ordered_count desc";
		
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
	
	// ��ȸ������ ��ǰ ������(ī�װ�) -0502����
	public ArrayList<GoodsBean> getCategoryProductList_hits(String category_code) throws Exception {
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
				+ "	where category_code = ?"
				+ " order by product_hits desc";
		
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
	
	// ���� ���� ������ ��ǰ ������(ī�װ�) -0502����
	public ArrayList<GoodsBean> getCategoryProductList_price_desc(String category_code) throws Exception {
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
				+ "	where category_code = ?"
				+ " order by product_price desc";
		
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
	
	// ���� ���� ������ ��ǰ ������(ī�װ�) -0502����
	public ArrayList<GoodsBean> getCategoryProductList_price(String category_code) throws Exception {
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
				+ "	where category_code = ?"
				+ " order by product_price";
		
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
	
	
	// ���� �ȸ� ������ ��ǰ �̹��� ������ -0429���� 
	public ArrayList<GoodsBean> getProductimg_best(ArrayList<GoodsBean> ProductlistArr) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//System.out.println(ProductlistArr.size());
		if(ProductlistArr.size()!=0) {
			//System.out.println("@@@@�迭��ũ��� ��ǰ�ǹ�ȣ��"+ProductlistArr.get(0).getProduct_number());
		}
		
		
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
						//product.setStored_thumbnail(rs.getString("stored_thumbnail"));
						//product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
						product.setFile_size(rs.getInt("file_size"));
						product.setCreate_date(rs.getTimestamp("create_date"));
						//product.setDelete_check(rs.getString("delete_check"));
						ProductimgArr.add(product);
					}else {
						product.setFile_number(rs.getInt("file_number"));
						product.setProduct_number(rs.getInt("product_number"));
						product.setOrgin_file_name("�̹�������");
						product.setStored_file_name("�̹�������");
						//product.setStored_thumbnail("�̹�������");
						//product.setDelegate_thumbnail("�̹�������");
						product.setFile_size(0);
						product.setCreate_date(null);
						//product.setDelete_check("�̹�������");
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
	
	//��ü��ǰ����Ʈ��ȯ - �Ǹż�	-0501����
	public ArrayList<GoodsBean> getProductlist_best() throws Exception {
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
							+ " from product"
							+ " order by product_ordered_count desc";
		
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

	//��ü��ǰ����Ʈ��ȯ - ��ȸ��	-0501����
	public ArrayList<GoodsBean> getProductlist_hits() throws Exception {
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
							+ " from product"
							+ " order by product_hits desc";
		
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
	
	//��ü��ǰ����Ʈ��ȯ - �������ݼ�	-0501����
	public ArrayList<GoodsBean> getProductlist_price_desc() throws Exception {
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
							+ " from product"
							+ " order by product_price desc";
		
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
	
	//��ü��ǰ����Ʈ��ȯ - �������ݼ�	-0501����
	public ArrayList<GoodsBean> getProductlist_price() throws Exception {
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
							+ " from product"
							+ " order by product_price";
		
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
							+ "	where category_code = ?"
							+ " order by product_number desc ";
		
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
						" where product_name like ? or product_desc like ?";
		
		ArrayList<GoodsBean> ProductArr = new ArrayList<GoodsBean>();
		GoodsBean product = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1,"%" +searchtext+"%" );
			
			pstmt.setString(2,"%" + searchtext+"%" );
			
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
	
	
	

	
	//��ǰ�̹���  �ҷ����� �����̹�������
	public ArrayList<GoodsBean> getGoodsimg(int product_number) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		System.out.println("����?");
		
//		query = "select stored_thumbNail,file_size from product_imagefile where product_number = ?";
		
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
							+ " where product_number = ?"
							+ " order by file_number";
		ArrayList<GoodsBean> getGoodsimgs = new ArrayList<GoodsBean>();
		GoodsBean product = null;
			
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, product_number);
			rs = pstmt.executeQuery();
		
			
			while (rs.next()) {
				product = new GoodsBean();
			
				if(rs.getString("stored_file_name") != null){
					product.setOrgin_file_name(rs.getString("orgin_file_name"));
					product.setStored_file_name(rs.getString("stored_file_name"));		
					product.setFile_size(rs.getInt("file_size"));
					getGoodsimgs.add(product);
				}else if(rs.getString("stored_thumbnail") != null) {
					product.setOrgin_file_name(rs.getString("orgin_file_name"));
					product.setStored_thumbnail(rs.getString("stored_thumbnail"));
					product.setFile_size(rs.getInt("file_size"));
					getGoodsimgs.add(product);
				}else if( rs.getString("orgin_file_name") == null){
					product.setFile_number(rs.getInt("file_number"));
					product.setProduct_number(rs.getInt("product_number"));
					product.setOrgin_file_name("�̹�������");
					product.setStored_file_name("�̹�������");
					product.setStored_thumbnail("�̹�������");
					product.setDelegate_thumbnail("�̹�������");
					product.setFile_size(0);
					product.setCreate_date(null);
					product.setDelete_check("�̹�������");
					getGoodsimgs.add(product);		
				}
				
				
			}
			
		} catch(Exception e) {
			System.out.println("�̹��� �ε� ����");
			e.printStackTrace();
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return getGoodsimgs;
	}
	
	
	//
	
	
	
	//��ü��ǰ����Ʈ��ȯ
		public ArrayList<GoodsBean> getProductlist() throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
//			System.out.println("����?");
			String query = "select product_number"
								+ ",category_code"
								+ ",product_name"
								+ ",product_price"
								+ ",product_stock"
								+ ",product_desc"
								+ ",product_date"
								+ ",product_hits"
								+ " from product"
								+ " order by product_number desc";
			
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
		
		//��ǰ �̹��� ����Ʈ 
		public ArrayList<GoodsBean> getProductimg(ArrayList<GoodsBean> ProductlistArr) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			//System.out.println(ProductlistArr.size());
			if(ProductlistArr.size()!=0) {
				//System.out.println("@@@@�迭��ũ��� ��ǰ�ǹ�ȣ��"+ProductlistArr.get(0).getProduct_number());
			}
			
			
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
								+ " where product_number = ?"
								+ " order by file_number";
//			System.out.println(ProductlistArr.size());
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
							//product.setStored_thumbnail(rs.getString("stored_thumbnail"));
							//product.setDelegate_thumbnail(rs.getString("delegate_thumbnail"));
							product.setFile_size(rs.getInt("file_size"));
							product.setCreate_date(rs.getTimestamp("create_date"));
							//product.setDelete_check(rs.getString("delete_check"));
							ProductimgArr.add(product);
						}else {
							product.setFile_number(rs.getInt("file_number"));
							product.setProduct_number(rs.getInt("product_number"));
							product.setOrgin_file_name("�̹�������");
							product.setStored_file_name("�̹�������");
							//product.setStored_thumbnail("�̹�������");
							//product.setDelegate_thumbnail("�̹�������");
							product.setFile_size(0);
							product.setCreate_date(null);
							//product.setDelete_check("�̹�������");
							ProductimgArr.add(product);
							
						}
//						System.out.println("");
						
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
	

}
