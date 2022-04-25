x<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	// 비회원 튕기기 안되고있음ㅠㅠ 근지
	String user_id = null;
	if(session.getAttribute("user")==null) {
%>		
		<script>
		alert("로그인이 필요한 페이지입니다.");
		location.href = "../login/login.jsp";
		return;
		</script>
<%
	}
	user_id = (String)session.getAttribute("user_id");
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	
	UserDBBean userDb = UserDBBean.getInstance();
	UserBean user = userDb.getUser(user_id);
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number);
	
	int total_price = goods.getProduct_price()*product_count;
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
		<form method="post" name="re_user_frm" action="buyOk.jsp">
			<input type="hidden" name="product_number" value="<%= product_number %>">
			<input type="hidden" name="product_count" value="<%= product_count %>">
			<input type="hidden" name="product_price" value="<%= total_price %>">
				<table>
					<caption>주문 목록</caption>
						<tr>
							<td>제품명</td>
							<td>수량</td>
							<td>가격</td>
						</tr>
						<tr>
							<td><%= goods.getProduct_name() %></td>
							<td><%= product_count %></td>
							<td><%= total_price %></td>
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