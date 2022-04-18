<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = request.getParameter("user_id");
	CartDBBean db = CartDBBean.getInstance();
	ArrayList<CartBean> cartArr = db.getCart(user_id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%= user_id %>님의 장바구니 <br><br>
	<table>
		<tr>
			<td>
				상품 번호
			</td>
			<td>
				상품 수량
			</td>
		</tr>	
	<%
		// 추가로 상품 정보가 더 필요하다면 DAO에서 goods랑 join해서 받아오기 / 아니면 goodsBean으로 goods정보 받아오기! -0418근지
		for(int i=0; i<cartArr.size(); i++) {
			CartBean cart = cartArr.get(i);
	%>
			<tr>
			<td>
				<%= cart.getProduct_number() %>
			</td>
			<td>
				<%= cart.getProduct_count() %>
			</td>
		</tr>
	<%
		}
	%>
	</table>
</body>
</html>