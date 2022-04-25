<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean userDb = UserDBBean.getInstance();
	UserBean user = userDb.getUser(user_id);
	
	CartDBBean cartDb = CartDBBean.getInstance();
	CartBean cart = null;
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = null;
	
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
	<h1>�ֹ� �� ������</h1>
		<form action="buyOkFromCart.jsp">
				<table>
					<caption>�ֹ� ���</caption>
			<%			
						int total_price = 0;
						for(int i=0; i<cart_num_arr.length; i++) {
							cart = cartDb.getCart_one(Integer.parseInt(cart_num_arr[i]));
							goods = goodsDb.getGoods(cart.getProduct_number());
			%>			
						<!-- �� �ѱ�� ����. ���߿� �ش� üũ�ڽ��� css�� ������ �ʰ� �����ϱ�	-0425���� -->
						<input type="checkbox" value="<%= cart_num_arr[i] %>" name="cart_num_arr" checked onclick="return false;">
							<tr>
								<td>��ǰ��</td>
								<td>����</td>
								<td>����</td>
							</tr>
							<tr>
								<td><%= goods.getProduct_name() %></td>
								<td><%= cart.getProduct_count() %></td>
								<td><%= goods.getProduct_price()*cart.getProduct_count() %></td>
			<%
								total_price += goods.getProduct_price()*cart.getProduct_count();
						}
			%>				
							<tr>
								<td>�� ����</td>
								<td colspan="2"><%= total_price %></td>
							</tr>	
				</table>
				<table>
					<caption>��� ����</caption>
						<tr>
							<td colspan="2">
								<input type="checkbox" id="check">ȸ�������� ����
							</td>
						</tr>
						<tr>
							<td>�̸�</td>
							<td><input type="text" name="receiver_name" id="re_name"></td>
						</tr>
						<tr>
							<td>�޴��� ��ȣ</td>
							<td><input type="text" name="receiver_phone" id="re_phone"></td>
						</tr>
						<tr>
							<td>�ּ�</td>
							<td><input type="text" name="receiver_addr" id="re_addr"></td>
						</tr>
						<tr>
							<td><input type="submit" value="�����ϱ�"></td>
						</tr>
				</table>
		</form>

</body>
</html>