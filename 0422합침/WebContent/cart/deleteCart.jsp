<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	int cart_number = Integer.parseInt(request.getParameter("cart_number"));
	CartDBBean db = CartDBBean.getInstance();
	int re = db.deleteCart(cart_number);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		if(re==1) {
	%>
			<script>
				alert("�ش� ��ǰ�� ��ٱ��Ͽ��� ���� �Ǿ����ϴ�.");
				location.href="viewCart.jsp";
			</script>
	<%
		} else {
	%>
			<script>
				alert("��ٱ��� ���� ����");
				history.go(-1);
			</script>
	<%
		}
	%>
</body>
</html>