<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean userDb = UserDBBean.getInstance();
	UserBean user = userDb.getUser(user_id);
	
	CartDBBean cartDb = CartDBBean.getInstance();
	CartBean cart = null;
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = null;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<script src="../js/jquery.js"></script>
	<script>
	$(function () {
		$("#check").change(function() {
			if($("#check").is(":checked")) {
				document.getElementById("re_name").value = "<%= user.getUser_name() %>";
				document.getElementById("re_phone").value = "<%= user.getUser_phone() %>";
				document.getElementById("re_addr").value = "<%= user.getUser_addr() %>";
			} else {
				document.getElementById("re_name").value = null;
				document.getElementById("re_phone").value = null;
				document.getElementById("re_addr").value = null;
			}
		});
	});
	</script>
</head>
<body>
	<h1>주문 상세 페이지</h1>
		<form action="buyOkFromCart.jsp">
				<table>
					<caption>주문 목록</caption>
			<%			
						int total_price = 0;
						for(int i=0; i<cart_num_arr.length; i++) {
							cart = cartDb.getCart_one(Integer.parseInt(cart_num_arr[i]));
							goods = goodsDb.getGoods(cart.getProduct_number());
			%>			
						<!-- 값 넘기기 위해. 나중에 해당 체크박스는 css로 보이지 않게 설정하기	-0425근지 -->
						<input type="checkbox" value="<%= cart_num_arr[i] %>" name="cart_num_arr" checked onclick="return false;">
							<tr>
								<td>제품명</td>
								<td>수량</td>
								<td>가격</td>
							</tr>
							<tr>
								<td><%= goods.getProduct_name() %></td>
								<td><%= cart.getProduct_count() %></td>
								<td><%= goods.getProduct_price()*cart.getProduct_count() %></td>
			<%
								total_price += goods.getProduct_price()*cart.getProduct_count();
						}
			%>				
							<tr>
								<td>총 가격</td>
								<td colspan="2"><%= total_price %></td>
							</tr>	
				</table>
				<table>
					<caption>배송 정보</caption>
						<tr>
							<td colspan="2">
								<input type="checkbox" id="check">회원정보와 동일
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" name="receiver_name" id="re_name"></td>
						</tr>
						<tr>
							<td>휴대폰 번호</td>
							<td><input type="text" name="receiver_phone" id="re_phone"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text" name="receiver_addr" id="re_addr"></td>
						</tr>
						<tr>
							<td><input type="submit" value="결제하기"></td>
						</tr>
				</table>
		</form>

</body>
</html>