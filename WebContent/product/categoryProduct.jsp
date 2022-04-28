<%@page import="java.io.File"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>

 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%@include file= "../main/mainClass.jsp"%>  
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>

<%
	request.setCharacterEncoding("UTF-8");
    path = request.getRealPath("upload");
    
%>


<%
  	category_code = request.getParameter("category");
	//System.out.println("@@@@@@@@@@@@@"+category_code);
	String goods = null;
	if(category_code.equals("1")){
		goods = "상의";
		category_code = "상의";
	}else if(category_code.equals("2")){
		goods = "하의";
		category_code = "하의";
	}else{
		goods = "신발";
		category_code = "신발";
	}
	GoodsDBBean productdb = new GoodsDBBean();
	ArrayList<GoodsBean> CategoryProductList = productdb.getCategoryProductList(category_code);
 	ArrayList<GoodsBean> productlistArr  =  productdb.getProductimg(CategoryProductList);
 	int j = 0;
 	int size = 0;
 	if(CategoryProductList.size()%4 != 0){
 		size = CategoryProductList.size()/4+1 ;
 	}else{
 		size = CategoryProductList.size()/4;
 	} 
%>
	
	<nav class="nav2" >
	
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page"><%=goods %></li>
		  </ul>
		</nav>
		<div style="clear: both; font-size: large; color: black;">
			<%=goods %>
		</div>
		<div class="d-flex justify-content-between"  style="clear: both;  margin-top: 35px; padding-bottom: 10px; border-bottom: 1px rgba(0, 0, 0, 0.09) solid">
			<div class="nav navbox" >
				Total
			</div>
			<div class="nav justify-content-end ulbox">
				판매순
			</div>
		</div>
	</nav>
       	<div class="goods">
 <%
	     	
	     	out.print("<table>");
	     	//번for 문
	     	for(int i=0; i<size; i++){
	     		out.print("<tr>");
	     		int num =i*4;
	     		//2번 for 문
	     
	     		for(j=0+num; j<=3+num; j++){
	     			if(CategoryProductList.size()==j) break;
	     		
					
					
					
	     			product_number= CategoryProductList.get(j).getProduct_number();
	     			category_code = CategoryProductList.get(j).getCategory_code();
	     			product_name = CategoryProductList.get(j).getProduct_name();
	     			product_price =CategoryProductList.get(j).getProduct_price();
	     			product_stock = CategoryProductList.get(j).getProduct_stock();
	     			product_desc = CategoryProductList.get(j).getProduct_desc();
	     			product_hits = CategoryProductList.get(j).getProduct_hits();
	     			
	     			
	     			file_number =productlistArr.get(j).getFile_number();
	     			orgin_file_name = productlistArr.get(j).getOrgin_file_name();
	     			stored_file_name = productlistArr.get(j).getStored_file_name();
	     			stored_thumbnail = productlistArr.get(j).getStored_thumbnail();
	     			delegate_thumbnail =productlistArr.get(j).getDelegate_thumbnail();
	     			file_size = productlistArr.get(j).getFile_size();
	     			create_date = productlistArr.get(j).getCreate_date();
	     			delete_check = productlistArr.get(j).getDelete_check();
					
					String orgin_file_namearr[] = orgin_file_name.split("/");
					String stored_file_namearr[] = stored_file_name.split("/");
					//파일존재확인
					File file = new File(path+"\\"+stored_file_namearr[0]);
					boolean isExists = file.exists();
					if(isExists) { System.out.println("I find the existFile.txt"); } 
					else { System.out.println("No, there is not a no file."); }
%>
	 				
					   <td>
							<table>
								<tr>
									<td class="mainalinkimg">
										<%if(isExists){%>
										 <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
											<img src="<%= request.getContextPath() %><%= File.separator %>upload<%= File.separator %><%=stored_file_namearr[0]%>"  alt="이미지없음">
										 </a>
										<%}else{%>
										  <a href="./../cart/goodsDisplay.jsp?product_number=<%=product_number%>">
											<img src="../images/products/noimg.PNG"  alt="이미지없음">
										  </a>
										<%}%>
									</td>
								</tr>
								<tr  style = "cursor:pointer;" onclick="location.href='../cart/goodsDisplay.jsp?product_number=<%=product_number%>'">
									 	<td style="border-bottom: 1px rgba(0, 0, 0, 0.09) solid; line-height: 30px;">	
									 			<%=product_name %>
									 	</td>
									
								</tr>
								<tr>
									<td style="color: rgb(0, 139, 204); line-height: 15px;">판매가 :<%=product_price%> won</td>
								</tr>
							</table>
						</td>
		 	   
		 	
 <%

	     		}
	     		out.print("</tr>");
	     	}
	     	out.print("</table>");
 %>
	    </div>
  
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>

