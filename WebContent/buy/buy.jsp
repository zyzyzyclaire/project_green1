x<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	// ��ȸ�� ƨ��� �ȵǰ������Ф� ����
	String user_id = null;
	if(session.getAttribute("user")==null) {
%>		
		<script>
		alert("�α����� �ʿ��� �������Դϴ�.");
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
	<h1>�ֹ� �� ������</h1>
		<form method="post" name="re_user_frm" action="buyOk.jsp">
			<input type="hidden" name="product_number" value="<%= product_number %>">
			<input type="hidden" name="product_count" value="<%= product_count %>">
			<input type="hidden" name="product_price" value="<%= total_price %>">
				<table>
					<caption>�ֹ� ���</caption>
						<tr>
							<td>��ǰ��</td>
							<td>����</td>
							<td>����</td>
						</tr>
						<tr>
							<td><%= goods.getProduct_name() %></td>
							<td><%= product_count %></td>
							<td><%= total_price %></td>
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