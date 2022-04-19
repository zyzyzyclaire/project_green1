<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	int cart_number = Integer.parseInt(request.getParameter("cart_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	CartDBBean db = CartDBBean.getInstance();
	int re = db.editCart(cart_number, product_count);
%>
<%
	if(re==1) {
%>
		<script>
			alert("수정 되었습니다.");
			location.href="viewCart.jsp";
		</script>
<%
	} else {
%>
		<script>
			alert("수정 실패");
			history.go(-1);
		</script>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>