<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="../main/main.jsp">메인으로가기</a>
	<br>
<%
	String path = request.getRealPath("upload");
	request.setCharacterEncoding("UTF-8");

	String  searchtext = request.getParameter("searchtext");
	GoodsDBBean productdb = GoodsDBBean.getInstance();
	
	
	if(productdb.getsearch(searchtext).size()==0){
		
		%>
		<script>
			location.href ="../main/main.jsp?searchCheck=false";
		 	<%-- location.href ="../main/main.jsp?searchCheck=false&searchtext=<%=searchtext%>"; --%>
		</script>
		<%
		//response.sendRedirect("../main/main.jsp?searchCheck=true");
	}else{
		
	
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

	
	
	
		
	
  ArrayList<GoodsBean> productSearchlistArr  =  productdb.getsearch(searchtext);
	ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(productSearchlistArr);
	
	for(int j = 0; j<productlistArr.size(); j++){
		product_number= productSearchlistArr.get(j).getProduct_number();
			category_code = productSearchlistArr.get(j).getCategory_code();
			product_name = productSearchlistArr.get(j).getProduct_name();
			product_price =productSearchlistArr.get(j).getProduct_price();
			product_stock = productSearchlistArr.get(j).getProduct_stock();
			product_desc = productSearchlistArr.get(j).getProduct_desc();
			//product_date = CategoryProductList.get(i).getProduct_date();
			product_hits = productSearchlistArr.get(j).getProduct_hits();
			
			file_number =productlistArr.get(j).getFile_number();
			
			
			
		
			
			
			product_number2 = productlistArr.get(j).getProduct_number();
			orgin_file_name = productlistArr.get(j).getOrgin_file_name();
			String orgin_file_namearr[] = orgin_file_name.split("/");
			stored_file_name = productlistArr.get(j).getStored_file_name();
			String stored_file_namearr[] = stored_file_name.split("/");
			stored_thumbnail = productlistArr.get(j).getStored_thumbnail();
			delegate_thumbnail =productlistArr.get(j).getDelegate_thumbnail();
			file_size = productlistArr.get(j).getFile_size();
			create_date = productlistArr.get(j).getCreate_date();
			delete_check = productlistArr.get(j).getDelete_check(); 
			
			%>
			
				  <table border="">
				  			<tr> <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>"><img src=" <%=path%>\<%=stored_file_namearr[0]%>" style="width: 300px; height: 300px;"></a></tr>
					    	<tr>
					    		<td width="80px" style="text-align: center">상품이름:<%=orgin_file_name%></td>
								
								<td width="80px" style="text-align: center">상품가격:<%=product_price %></td>
							</tr>
							<tr>
								<td  colspan="2" width="100px" style="text-align: center">상품재고량:<%=product_stock%></td>
							</tr>
					    </table>
			<%
	}
	 
%>


<%
	



	}

%>

</body>
</html>