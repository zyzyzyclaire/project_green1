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
<script src="../js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$("#setCart").on("click", function() {
			confirm("장바구니에 담으시겠습니까?");
			var value = $('#product_count').val();
			if(value == 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				location.href="cartProcess.jsp?product_count="+value+"&product_number="+<%= product_number %>;
			}
		});
	});
	
	// 바꾼 수량에 재고가 없을 시 알림창 띄우도록 함 -0420근지
	$(function () {
		$("#product_count").on("change",function() {
			var value = $('#product_count').val();
			if(value == 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				location.href="checkStock.jsp?product_count="+value+"&product_number="+<%= product_number %>;
			}
		});
	});
	
	// 구매하기 버튼 눌렀을 때 실행됨 -0421근지
	$(function () {
		$("#buyCount").on("click",function() {
			var value = $('#product_count').val();
			if(value == 0) {
				alert("상품 수량을 선택해주세요.");
			} else {
				document.goods_frm.submit();
			}
		});
	});
	
	
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
	수량 : <br>
	<form method="post" action="../buy/buy.jsp" name="goods_frm">
		<input type="hidden" name="product_number" value="<%= product_number %>">
			<select name="product_count" id="product_count">
				<option value="0" selected>수량을 선택하세요.</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
		<input type="button" value="장바구니 담기" id="setCart">
		<input type="button" value="구매하기" id="buyCount">
	</form>
	<br><br>
	장바구니 보기 : <br>
	<input type="button" value="장바구니 보기" onclick="viewCart()">
</body>
</html>