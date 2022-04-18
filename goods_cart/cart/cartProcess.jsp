<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	String user_id = request.getParameter("user_id");
	int product_count = Integer.parseInt(request.getParameter("product_count"));

	
	
	// 회원이 아닐 때는 장바구니 등록이 불가능함 - 0418 근지
	if(user_id.equals("null")) {	// 쿼리스트링으로 넘어와서 문자열 null로 확인 -0418근지
%>
		<script>
			alert("회원만 장바구니 등록이 가능합니다.");
			history.back();
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
	<%
		CartDBBean db = CartDBBean.getInstance();
	%>
	<%
		if(db.insertCart(user_id, product_number, product_count) ==1) {
	%>		
			<script type="text/javascript">
			alert("장바구니 저장 완료.");
			history.back();
			</script>
	<%
		} else {
	%>
				<script>
				alert("장바구니 저장 실패했습니다.");
				document.location.href="goodsDisplay.jsp";
				</script>
	<%	
		}
	%>
</body>
</html>