<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
// 임시로 변수 설정함
	
	String user_id = (String)session.getAttribute("user_id");
	
	String product_name = "name2";
	int product_number = 2;
	int product_count = 2;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script type="text/javascript"> 
	function cartProcess(product_name, product_number, product_count) {
		if(confirm(product_name+" 을/를 장바구니에 담으시겠습니까?")) { 
			location.href = "cartProcess.jsp?product_number="+product_number+"&product_count="+product_count; 
		}
	} 
	
	function viewCart(user_id) { 
		if(confirm("장바구니를 보시겠습니까?")){ 
			location.href = "viewCart.jsp"; 
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>님 <br><br>
	상품 번호 : 세션으로 받아오기<br>
	상품명 :  빈으로 받기 <br>
	상품 가격 :  빈으로 받기 <br>
	장바구니 담기 : <br>
	<input type="button" value="장바구니 담기" onclick="cartProcess('<%=product_name%>', '<%=product_number%>', '<%=product_count%>')">
	<br><br>
	장바구니 보기 : <br>
	<input type="button" value="장바구니 보기" onclick="viewCart()">
</body>
</html>