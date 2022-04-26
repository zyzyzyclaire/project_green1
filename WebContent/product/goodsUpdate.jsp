<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<a href="./../main/main.jsp">메인으로가기</a>
<meta charset="UTF-8">
 <%
    	request.setCharacterEncoding("UTF-8");
 %>
<title>Insert title here</title>
<%

	int product_number = Integer.parseInt( request.getParameter("product_number"));
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number); //상품정보를가져온다
	//ArrayList<GoodsBean> getGoodsimg = goodsDb.getGoodsimg(product_number);
	String category_code = null;
	String product_name = null;
	int product_price = 0;
	int product_stock = 0;
	String product_desc = null;
	
	


  	product_name = goods.getProduct_name();
	product_price = goods.getProduct_price();
	product_stock = goods.getProduct_stock();
	product_desc = goods.getProduct_desc();
	category_code = goods.getCategory_code();
	//System.out.println("category_code@@@>>"+category_code);
	%>
	 <script src="../js/jquery.js"></script>
	<script>
		window.onload = function () {
			var category_code = '<%=category_code%>';
			$("#category_code").val(category_code).prop("selected", true);	
		}
	</script>

<script type="text/javascript">
function product_check_ok(){
	
	if(document.product_frm.product_name.value.length == 0){
		alert("상품이름을입력하세요");
		document.product_frm.product_name.focus();
		return;
	}	
	if(document.product_frm.product_price.value.length == 0){
		alert("가격을입력하세요");
		document.product_frm.product_price.focus();
		return;
	}	
	if(document.product_frm.product_stock.value.length == 0){
		alert("상품수량을입력하세요");
		document.product_frm.product_stock.focus();
		return;
	}	
	if(document.product_frm.product_desc.value.length == 0){
		alert("상품설명을입력하세요");
		document.product_frm.product_desc.focus();
		return;
	}	
	
	if(document.product_frm.category_code.value.length == 0){
		alert("상품종류를선택하세요");
		document.product_frm.category_code.focus();
		return;
	}	

	// userUpdate.jsp의 form action값으로 submit함
	document.product_frm.submit();
}


</script>		
 <script>
 cnt=1;
 function input_append(ff){
   cnt++;
   app = document.getElementById("append");
   app.innerHTML +="<tr><td>"+cnt+"</td><td colspan=2> <input type=file name=product_img"+cnt+" size=40 maxlength=100></td></tr>";
   //document.product_frm.submit();
 }
</script>					
	<form  name="product_frm" action="goodsUpdateOk.jsp" method="post" enctype="multipart/form-data">
		<table id="append" border="1">
			<input type="hidden" name="product_number" value="<%= product_number%>">
			<tr>
				<td>상품이름</td>
				<td><input type="text" name="product_name" value="<%=product_name%>"></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><input type="text" name="product_price" value="<%= product_price%>"></td>
			</tr>
			<tr >
				<td>상품수량</td>
				<td><input type="text" name="product_stock" value="<%=product_stock %>"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><input type="text" name="product_desc" value="<%=product_desc %>"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="category_code" id="category_code"> 
						<option value="상의">상의</option>
						<option value="하의">하의</option>
						<option value="신발">신발</option>
					</select>
				</td>
			</tr>
			 <tr>
				<td><input type="button" value="수정" onclick="product_check_ok()"></td>
			</tr>
		 
			<tr>
			
				<td>대표이미지</td>
				<td>
					 <input  type="file" name="product_img1" size="40" maxlength="100" >
				</td>
				
			</tr>
			
			
			
		</table>
	</from>	
	<input type="button" value="input 태그 추가" onclick="input_append(this.form)">
</head>
<body>

</body>
</html>