<!--@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@# 
	이제 안 씀 혹시 몰라 남겨둔 파일 categoryProduct_sort1/2/3/4/5.jsp 필요함	-0502근지 
	@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#-->
<%@page import="java.io.File"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "../main/mainClass.jsp"%>  
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
 	
 	// 베스트상품 4개를 얻어오기 위해	-0429근지
	ArrayList<GoodsBean> CategoryProductList_best = productdb.getCategoryProductList_best(category_code);
 	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery.js"></script>
<script>
	//페이지 로드될때 새로고침
	$(document).on("pageload",function(){
	  window.location.reload(true);
	});

	$(function() {
		// selectBox 강제 change
		$(document).ready(function(){
		    $('#sort') .val('newest').trigger('change');
		});
		
		// selectBox가 바뀌었을 때
		$("#sort").on("change", function() {
			var selectValue = $("#sort").val();
			alert(selectValue);
	 		if(selectValue=="newest"){
	   			document.getElementById("sort_result1").style.display = "block";
	   			document.getElementById("sort_result2").style.display = "none";
	   			document.getElementById("sort_result3").style.display = "none";
	   			document.getElementById("sort_result4").style.display = "none";
	   			document.getElementById("sort_result5").style.display = "none";
	   		}
	  		if(selectValue=="product_ordered_count"){
	   			document.getElementById("sort_result1").style.display = "none";
	   			document.getElementById("sort_result2").style.display = "block";
	   			document.getElementById("sort_result3").style.display = "none";
	   			document.getElementById("sort_result4").style.display = "none";
	   			document.getElementById("sort_result5").style.display = "none";
	   		}
	  		if(selectValue=="product_hits"){
	   			document.getElementById("sort_result1").style.display = "none";
	   			document.getElementById("sort_result2").style.display = "none";
	   			document.getElementById("sort_result3").style.display = "block";
	   			document.getElementById("sort_result4").style.display = "none";
	   			document.getElementById("sort_result5").style.display = "none";
	   		}
	  		if(selectValue=="product_price_desc"){
	   			document.getElementById("sort_result1").style.display = "none";
	   			document.getElementById("sort_result2").style.display = "none";
	   			document.getElementById("sort_result3").style.display = "none";
	   			document.getElementById("sort_result4").style.display = "block";
	   			document.getElementById("sort_result5").style.display = "none";
	   		}
	  		if(selectValue=="product_price"){
	   			document.getElementById("sort_result1").style.display = "none";
	   			document.getElementById("sort_result2").style.display = "none";
	   			document.getElementById("sort_result3").style.display = "none";
	   			document.getElementById("sort_result4").style.display = "none";
	   			document.getElementById("sort_result5").style.display = "block";
	   		}
			
		});
		
	});
</script>

<style>
	.best_tr {
		height:10px;
	}
	.best_td {
		border-top: 1px solid #e0e0e0;
		padding-top: 3px;
		text-align: center;
	}
</style>

</head>
<body>
<link rel="stylesheet" href="../css/nav.css" type = "text/css">
<jsp:include page="../main/mainHeader.jsp"></jsp:include>
	
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
		
		<!-- 베스트 상품 4개만 출력 -0429근지-->
       	<div class="goods">
 <%
	     	out.print("<table>");

	     	//번for 문
	     	for(int i=0; i<1; i++){
	     		out.print("<tr>");
	     		//2번 for 문	     
	     		for(j=0; j<=3; j++){
	     			if(CategoryProductList.size()==j) break;
					
	     			product_number= CategoryProductList_best.get(j).getProduct_number();
	     			category_code = CategoryProductList_best.get(j).getCategory_code();
	     			product_name = CategoryProductList_best.get(j).getProduct_name();
	     			product_price =CategoryProductList_best.get(j).getProduct_price();
	     			product_stock = CategoryProductList_best.get(j).getProduct_stock();
	     			product_desc = CategoryProductList_best.get(j).getProduct_desc();
	     			product_hits = CategoryProductList_best.get(j).getProduct_hits();
	     			
	     			GoodsBean getGoodsImg = productdb.getGoodsImg(product_number);
	     			
	     			file_number = getGoodsImg.getFile_number();
	     			orgin_file_name = getGoodsImg.getOrgin_file_name();
	     			stored_file_name = getGoodsImg.getStored_file_name();
	     			stored_thumbnail = getGoodsImg.getStored_thumbnail();
	     			delegate_thumbnail = getGoodsImg.getDelegate_thumbnail();
	     			file_size = getGoodsImg.getFile_size();
	     			create_date = getGoodsImg.getCreate_date();
	     			delete_check = getGoodsImg.getDelete_check();
					
					String orgin_file_namearr[] = orgin_file_name.split("/");
					String stored_file_namearr[] = stored_file_name.split("/");
					//파일존재확인
					File file = new File(path+"\\"+stored_file_namearr[0]);
					boolean isExists = file.exists();
					/* if(isExists) { System.out.println("I find the existFile.txt"); } 
					else { System.out.println("No, there is not a no file."); } */
%>
		   <td>
				<table>
					<tr>
						<td class="best_td">BEST<%=j+1%></td>
					</tr>
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
	    
		<div class="d-flex justify-content-between"  style="clear: both;  margin-top: 35px; padding-bottom: 10px; border-bottom: 1px rgba(0, 0, 0, 0.09) solid">
			<div class="nav navbox" >
				Total <%= CategoryProductList.size() %>개
			</div>
			<div class="nav justify-content-end ulbox">
 				<select id="sort">
					<option value="newest" selected>최신순</option>
					<option value="product_ordered_count">판매순</option>
					<option value="product_hits">조회순</option>
					<option value="product_price_desc">높은가격순</option>
					<option value="product_price">낮은가격순</option>
				</select>
			</div>
		</div>
	</nav>
	 
 	<div id="sort_result1">
 		<jsp:include page="categoryProduct_sort1.jsp"></jsp:include>
 	</div>
 	<div id="sort_result2">
 		<jsp:include page="categoryProduct_sort2.jsp"></jsp:include>
 	</div>
 	<div id="sort_result3">
 		<jsp:include page="categoryProduct_sort3.jsp"></jsp:include>
 	</div>
 	<div id="sort_result4">
 		<jsp:include page="categoryProduct_sort4.jsp"></jsp:include>
 	</div>
 	<div id="sort_result5">
 		<jsp:include page="categoryProduct_sort5.jsp"></jsp:include>
 	</div>
  
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>
</body>
</html>
