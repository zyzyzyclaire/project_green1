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
	<%= user_id %>���� ��ٱ��� <br><br>
	<table>
		<tr>
			<td>
				��ǰ ��ȣ
			</td>
			<td>
				��ǰ ����
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
				<%= cart.getProduct_count() %>
			</td>
		</tr>
	<%
		}
	%>
	</table>
</body>
</html>