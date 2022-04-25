<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	if(user_id == null){
%>	
		<script>
			alert("�α����� �ʿ��� �������Դϴ�.");
		</script>
<%
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

<script src="../js/jquery.js"></script>
<script type="text/javascript">
	
	function deleteCart(cart_number) { 
		if(confirm("�ش� ��ǰ�� ��ٱ��Ͽ��� �����Ͻðڽ��ϱ�?")){ 
			location.href = "deleteCart.jsp?cart_number="+cart_number; 
		} 
	} 
	
	function editCart(i) { 
		var count = $('#product_count'+i).val();
		var pnum = $('#product_number'+i).val();
		var cnum = $('#cart_number'+i).val();
		
		if(confirm("�ش� ��ǰ�� �����Ͻðڽ��ϱ�?")){
			
			if(count <= 0) {
				alert("��ǰ ������ �������ּ���.");
			} else {
				location.href="editCart.jsp?product_count="+count+"&product_number="+pnum+"&cart_number="+cnum;
			}
		}
		 
	} 
	
</script>

</head>
<body>
	<%= user_id %>���� ��ٱ��� <br><br>
		<table>
			<tr>
				<td>
					üũ
				</td>
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
		%>	
			<form method="post" action="../buy/buyFromCart.jsp">
		<%
			// ��ٱ��� ��� -0419 ����
			for(int i=0; i<cartArr.size(); i++) {
				CartBean cart = cartArr.get(i);
				GoodsBean goods = goodsDb.getGoods(cart.getProduct_number());
				//System.out.println("@@@cart@"+cart.getCart_number());
				
				int cart_number = cart.getCart_number();
				int product_number = cart.getProduct_number();
		%>
				<input type="hidden" name="cart_number" value="<%= cart_number %>" id="cart_number<%=i%>">
				<input type="hidden" name="product_number" value="<%= product_number %>" id="product_number<%=i%>">
					<tr>
						<td>
							<input type="checkbox" name="cart_num_arr" value="<%= cart_number %>">
						</td>
						<td>
							<%= goods.getProduct_name() %>
						</td>
						<td>
							<input type="text" name="product_count" value="<%= cart.getProduct_count() %>" id="product_count<%=i%>">
						</td>
						<td>
							<%= goods.getProduct_price() %>�� * <%= cart.getProduct_count() %>�� = 
							<%= goods.getProduct_price()*cart.getProduct_count() %>��
						</td>
						<td>
							<input type="button" value="����"   onclick="editCart(<%=i%>)">
							<input type="button" value="����" onclick="deleteCart('<%= cart_number %>')">
						</td>
					</tr>
		<%
			}
		%>
				<tr>
					<td>
						<input type="submit" value="�����ϱ�">
					</td>
				</tr>
			</form>
		</table>
</body>
</html>