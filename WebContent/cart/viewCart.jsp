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
		if(confirm("�ش� ��ǰ�� ��ٱ��Ͽ��� �����Ͻðڽ��ϱ�?")){ 
			location.href = "deleteCart.jsp?cart_number="+cart_number; 
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>���� ��ٱ��� <br><br>
		<table>
			<tr>
				<td>
					��ǰ ��ȣ
				</td>
				<td>
					��ǰ ����
				</td>
				<td>
					���
				</td>
			</tr>	
		<%
			// �߰��� ��ǰ ������ �� �ʿ��ϴٸ� DAO���� goods�� join�ؼ� �޾ƿ��� / �ƴϸ� goodsBean���� goods���� �޾ƿ���! -0418����
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
					<input type="button" value="����" onclick="deleteCart('<%= cart.getCart_number() %>')">
				</td>
			</tr>
		<%
			}
		%>
		</table>
</body>
</html>