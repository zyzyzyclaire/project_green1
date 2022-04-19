<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	int product_number = Integer.parseInt(request.getParameter("product_number"));	

	GoodsDBBean db = GoodsDBBean.getInstance();
	GoodsBean goods = db.getGoods(product_number);
	String product_name = goods.getProduct_name();
	int product_price = goods.getProduct_price();
	int product_stock = goods.getProduct_stock();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">

	function cartProcess(product_name) {
		if(confirm(product_name+" 을/를 장바구니에 담으시겠습니까?")) { 
			document.cart_frm.submit();
		}
	} 
	
	function viewCart(user_id) { 
		if(confirm("장바구니를 보시겠습니까?")){ 
			location.href = "viewCart.jsp"; 
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>님 <br><br>
	상품 번호 : <%= product_number %><br>
	상품명 :  <%= product_name %> <br>
	상품 가격 :  <%= product_price %> <br>
	상품 재고 : <%=product_stock %><br>
	장바구니 담기 : <br>
	<form method="post" action="cartProcess.jsp" name="cart_frm">
	<input type="hidden" name="product_number" value="<%=product_number%>">
		<select name="product_count">
			<option value="1" selected>1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
		<input type="submit" value="장바구니 담기" onclick="cartProcess('<%=product_name%>')">
	</form>
	<br><br>
	장바구니 보기 : <br>
	<input type="button" value="장바구니 보기" onclick="viewCart()">
</body>
</html>