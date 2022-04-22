<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
request.setCharacterEncoding("UTF-8");
%>
<title>Insert title here</title>
</head>
	<script src="board.js" type="text/javascript"></script>s
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
		alert("상품수량을입력하세요");
		document.product_frm.product_desc.focus();
		return;
	}	
	
	if(document.product_frm.category_code.value.length == 0){
		alert("상품수량을입력하세요");
		document.product_frm.category_code.focus();
		return;
	}	

	// userUpdate.jsp의 form action값으로 submit함
	document.product_frm.submit();
}
</script>
<body>
<form   name="product_frm" action="productAddOK.jsp" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>상품이름</td>
			<td><input type="text" name="product_name"></td>
		</tr>
		<tr>
			<td>상품가격</td>
			
			<td><input type="text" name="product_price"></td>
		</tr>
		<tr>
			<td>상품수량</td>
			<td><input type="text" name="product_stock"></td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td><input type="text" name="product_desc"></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td><input type="text" name="category_code"></td>
		</tr>
		<tr>
			<td>상품이미지</td>
			<td><input  type="file" name="product_img1" size="40" maxlength="100"></td>
			<td><input type="file" name="product_img2" size="40" maxlength="100"></td>
			
		</tr>
		<tr>
			<td><input type="button" value="상품등록" onclick="product_check_ok()"></td>
		</tr>
	</table>
</form>
</body>
</html>