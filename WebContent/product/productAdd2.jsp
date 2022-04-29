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
	<script src="board.js" type="text/javascript"></script>
<script>
 cnt=1;
 function input_append(ff){
   cnt++;
   app = document.getElementById("append");
   app.innerHTML +="<tr><td>"+cnt+"</td><td colspan=2> <input type=file name=product_img"+cnt+" size=40 maxlength=100></td></tr>";
   //document.product_frm.submit();
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
		alert("상품수량을입력하세요");
		document.product_frm.product_desc.focus();
		return;
	}	
	
	if(document.product_frm.category_code.value.length == 0){
		alert("상품수량을입력하세요");
		document.product_frm.category_code.focus();
		return;
	}	
	/* $("#editCart").on("click", function() {} */
	
	/* var product_name = $('#product_count').val();
	var product_price = $('#product_number').val();
	var product_stock = $('#cart_number').val();
	var product_desc = $('#cart_number').val();
	var product_desc = $('#category_code').val(); */
	
	
	//var product_desc = $('#category_code').val();
	
	
	
	// userUpdate.jsp의 form action값으로 submit함
	document.product_frm.submit();
}



</script>
<body>
<form   name="product_frm" action="productAddOK.jsp" method="post" enctype="multipart/form-data">
	<table id="append" border="1">
		<tr>
			<td>상품이름</td>
			<td><input type="text" name="product_name" id="product_name"></td>
		</tr>
		<tr>
			<td>상품가격</td>
			
			<td><input type="text" name="product_price" id="product_price"></td>
		</tr>
		<tr>
			<td>상품수량</td>
			<td><input type="text" name="product_stock" id="product_stock"></td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td><input type="text" name="product_desc" id="product_desc"></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td>
				<select name="category_code"> 
					<option value="상의">상의</option>
					<option value="하의">하의</option>
					<option value="신발">신발</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>상품이미지</td>
			<td><input  type="file" name="product_img1" size="40" maxlength="100" id="product_img1"></td>
		</tr>
		<tr>
			<td><input type="button" value="상품등록" onclick="product_check_ok()"></td>
		</tr>
	</table>
	<input type="button" value="사진 추가" onclick="input_append(this.form)">
</form>
</body>
</html>