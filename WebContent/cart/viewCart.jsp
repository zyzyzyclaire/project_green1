<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	CartDBBean db = CartDBBean.getInstance();
	ArrayList<CartBean> cartArr = db.getCart(user_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">
	function deleteCart(cart_number) { 
		if(confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")){ 
			location.href = "deleteCart.jsp?cart_number="+cart_number; 
		} 
	} 
</script>

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
				<td>
					비고
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
					<input type="text" name="product_count" value="<%= cart.getProduct_count() %>">
				</td>
				<td>
					<input type="button" value="삭제" onclick="deleteCart('<%= cart.getCart_number() %>')">
				</td>
			</tr>
		<%
			}
		%>
		</table>
</body>
</html>