<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	if(user_id ==null){
		System.out.println("��ٱ��� �α��� �ض�");
		response.sendRedirect("../login/login.jsp");
	}

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
		if(confirm("�ش� ��ǰ�� ��ٱ��Ͽ��� �����Ͻðڽ��ϱ�?")){ 
			location.href = "deleteCart.jsp?cart_number="+cart_number; 
		} 
	} 
	
	function editCart() { 
		if(confirm("�ش� ��ǰ�� �����Ͻðڽ��ϱ�?")){ 
			document.edit_frm.submit();
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>���� ��ٱ��� <br><br>
		<table>
			<tr>
				<td>
					��ǰ �̸�
				</td>
				<td>
					�ֹ� ����
				</td>
				<td>
					����
				</td>
				<td>
					���
				</td>
			</tr>	
		<%
			// ��ٱ��ϰ� ����ٸ�	-0419 ����
			if(cartArr.size()==0) {
		%>
				<script>
					alert("��ٱ��ϰ� ������ϴ�.");
					location.href="../main/main.jsp";
				</script>
		<%
			}
			
			// ��ٱ��� ��� -0419 ����
			for(int i=0; i<cartArr.size(); i++) {
				CartBean cart = cartArr.get(i);
				GoodsBean goods = goodsDb.getGoods(cart.getProduct_number());

		%>
			<form method="post" action="editCart.jsp" name="edit_frm">
				<input type="hidden" name="cart_number" value="<%= cart.getCart_number()%>">
				<input type="hidden" name="product_number" value="<%= cart.getProduct_number()%>">
					<tr>
						<td>
							<%= goods.getProduct_name() %>
						</td>
						<td>
							<input type="text" name="product_count" value="<%= cart.getProduct_count() %>">
						</td>
						<td>
							<%= goods.getProduct_price() %>�� * <%= cart.getProduct_count() %>�� = 
							<%= goods.getProduct_price()*cart.getProduct_count() %>��
						</td>
						<td>
							<input type="submit" value="����">
							<input type="button" value="����" onclick="deleteCart('<%= cart.getCart_number() %>')">
						</td>
					</tr>
			</form>
		<%
			}
		%>
		</table>
</body>
</html>