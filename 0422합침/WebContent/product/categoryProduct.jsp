<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String path = request.getRealPath("upload");
	int product_number = 0;
	String category_code = null;
	String product_name = null;
	int product_price = 0;
	int product_stock = 0;
	String product_desc = null;
	Timestamp product_date = null;
	int product_hits = 0;

	  int product_number2 = 0;
	  int file_number = 0 ;
	  String orgin_file_name= null;
	  String stored_file_name= null;
	  String stored_thumbnail= null;
	  String delegate_thumbnail= null;
	  int file_size= 0;
	  Timestamp create_date= null;
	  String delete_check= null;
%>

<%
  category_code = request.getParameter("category");
	if(category_code.equals("1")){
		out.println("상의");
	}else if(category_code.equals("2")){
		out.println("하의");
	}else{
		out.println("신발");
	}
%>
	<%=category_code%>
	<%
	GoodsDBBean productdb = new GoodsDBBean();
	
	ArrayList<GoodsBean> CategoryProductList =productdb.getCategoryProductList(category_code);
	ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList);
	for(int i=0; i<CategoryProductList.size(); i++){
		product_number= CategoryProductList.get(i).getProduct_number();
 		category_code = CategoryProductList.get(i).getCategory_code();
 		product_name = CategoryProductList.get(i).getProduct_name();
 		product_price =CategoryProductList.get(i).getProduct_price();
 		product_stock = CategoryProductList.get(i).getProduct_stock();
 		product_desc = CategoryProductList.get(i).getProduct_desc();
 		//product_date = CategoryProductList.get(i).getProduct_date();
 		product_hits = CategoryProductList.get(i).getProduct_hits();
 		
 		  file_number =productlistArr.get(i).getFile_number();
		  product_number2 = productlistArr.get(i).getProduct_number();
		  orgin_file_name = productlistArr.get(i).getOrgin_file_name();
		  stored_file_name = productlistArr.get(i).getStored_file_name();
		  stored_thumbnail = productlistArr.get(i).getStored_thumbnail();
		  delegate_thumbnail =productlistArr.get(i).getDelegate_thumbnail();
		  file_size = productlistArr.get(i).getFile_size();
		  create_date = productlistArr.get(i).getCreate_date();
		  delete_check = productlistArr.get(i).getDelete_check(); 
		  System.out.print("@@이미지이름"+orgin_file_name);
  %>	  
		   <table border="1" >
			        <tr>
						<td colspan="6">
							<a href="./../cart/goodsDisplay.jsp?product_number=<%=orgin_file_name%>"><img src="<%=path%>/<%=stored_file_name%>" style="width: 300px; height: 300px;" ><a>
						</td>
					</tr>
					<tr>
						<td>상품이름</td>
						<td><%=orgin_file_name%></td>
						<td>상품가격</td>
						<td><%=product_price %></td>
						<td>상품재고량</td>
						<td><%=product_stock%></td>
					</tr>
			</table>
<%
		}

%>
	

</body>
</html>