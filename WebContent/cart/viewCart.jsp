<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	CartDBBean db = CartDBBean.getInstance();
	ArrayList<CartBean> cartArr = db.getCart(user_id);
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	
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
	
	function editCart() { 
		if(confirm("해당 상품을 수정하시겠습니까?")){ 
			document.edit_frm.submit();
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>님의 장바구니 <br><br>
		<table>
			<tr>
				<td>
					상품 이름
				</td>
				<td>
					주문 수량
				</td>
				<td>
					가격
				</td>
				<td>
					비고
				</td>
			</tr>	
		<%
			// 추가로 상품 정보가 더 필요하다면 DAO에서 goods랑 join해서 받아오기 / 아니면 goodsBean으로 goods정보 받아오기! -0418근지
			for(int i=0; i<cartArr.size(); i++) {
				CartBean cart = cartArr.get(i);
				GoodsBean goods = goodsDb.getGoods(cart.getProduct_number());
		%>
			<form method="post" action="editCart.jsp?cart_number=<%= cart.getCart_number()%>" name="edit_frm">
				<tr>
					<td>
						<%= goods.getProduct_name() %>
					</td>
					<td>
						<input type="text" name="product_count" value="<%= cart.getProduct_count() %>">
					</td>
					<td>
						가격 넣기
					</td>
					<td>
						<input type="submit" value="수정" onclick="editCart()">
						<input type="button" value="삭제" onclick="deleteCart('<%= cart.getCart_number() %>')">
					</td>
				</tr>
			</form>
		<%
			}
		%>
		</table>
</body>
</html>