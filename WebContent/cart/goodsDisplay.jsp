<%@page import="goods.GoodsDBBean"%>
<%@page import="goods.GoodsBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	int product_number = Integer.parseInt(request.getParameter("product_number"));	

	GoodsDBBean db = GoodsDBBean.getInstance();
	GoodsBean goods = db.getGoods(product_number);
	String product_name = goods.getProduct_name();
	int product_price = goods.getProduct_price();
	int product_stock = goods.getProduct_stock();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<script type="text/javascript">

	function cartProcess(product_name) {
		if(confirm(product_name+" ��/�� ��ٱ��Ͽ� �����ðڽ��ϱ�?")) { 
			document.cart_frm.submit();
		}
	} 
	
	function viewCart(user_id) { 
		if(confirm("��ٱ��ϸ� ���ðڽ��ϱ�?")){ 
			location.href = "viewCart.jsp"; 
		} 
	} 
</script>

</head>
<body>
	<%= user_id %>�� <br><br>
	��ǰ ��ȣ : <%= product_number %><br>
	��ǰ�� :  <%= product_name %> <br>
	��ǰ ���� :  <%= product_price %> <br>
	��ǰ ��� : <%=product_stock %><br>
	��ٱ��� ��� : <br>
	<form method="post" action="cartProcess.jsp" name="cart_frm">
	<input type="hidden" name="product_number" value="<%=product_number%>">
		<select name="product_count">
			<option value="1" selected>1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
		<input type="submit" value="��ٱ��� ���" onclick="cartProcess('<%=product_name%>')">
	</form>
	<br><br>
	��ٱ��� ���� : <br>
	<input type="button" value="��ٱ��� ����" onclick="viewCart()">
</body>
</html>