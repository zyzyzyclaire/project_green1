<%@page import="goods.GoodsBean"%>
<%@page import="goods.GoodsDBBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = null;
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	
	CartDBBean cartDb = CartDBBean.getInstance();
	
	GoodsDBBean goodsDb = GoodsDBBean.getInstance();
	GoodsBean goods = goodsDb.getGoods(product_number);
	int stock = goods.getProduct_stock();

	// ȸ���� �ƴ� ���� ��ٱ��� ����� �Ұ����� - 0418 ����
	if(session.getAttribute("user_id")==null) {
%>
		<script>
			alert("ȸ���� ��ٱ��� ����� �����մϴ�.");
			location.href="../login/login.jsp";
		</script>
<%	
	} else {	// ȸ���� �� - 0420 ����
		user_id = (String)session.getAttribute("user_id");
		
		// ��� ���� Ȯ�� - 0420 ����
		if(cartDb.checkStock(product_number, product_count, user_id) == -1) {	// ��� ���� -0420����
%>		
			<script>
			alert("��� ����. ��ٱ��Ͽ� ��� ��ǰ ������ Ȯ�� �� ������ �ٽ� �������ּ���.");
			history.back();
			</script>
<%			
		} else {
	
			// ��ٱ��Ͽ� ����	-0419 ����
			if(cartDb.insertCart(user_id, product_number, product_count) == -1) {
%>		
				<script>
				alert("��ٱ��� ���� ����");
				history.back();
				</script>
<%
			} else {
%>
				<script>
				alert("��ٱ��� ���� �Ϸ�");
				history.back();
				</script>
<%	
			}
		}
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