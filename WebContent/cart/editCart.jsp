<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	
	String user_id = (String)session.getAttribute("user_id");
	int cart_number = Integer.parseInt(request.getParameter("cart_number"));
	int product_count = Integer.parseInt(request.getParameter("product_count"));
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	
	System.out.println("cart_number@@@###===>"+cart_number);
	System.out.println("product_count@@@###===>"+product_count);
	System.out.println("product_number@@@###===>"+product_number);
	
	CartDBBean db = CartDBBean.getInstance();
	
	if(product_count <= 0) {	// ������ �߸� ���Խ�
%>		
		<script>
		alert("�ùٸ� ��ǰ ������ �������ּ���.");
		history.back();
		</script>
<%		
	}
	
	// ��� ���� Ȯ�� - 0420 ����
	else if(db.checkStockEdit(product_number, product_count) == -1) {	// ��� ���� -0420����
%>		
		<script>
		alert("��� ����. ��ǰ ������ �ٽ� �������ּ���.");
		history.back();
		</script>
<%		
		} else {	// ��� ���� -0420����

		if(db.editCart(cart_number, product_count)==1) {
%>
			<script>
				alert("���� �Ǿ����ϴ�.");
				location.href="viewCart.jsp";
			</script>
<%
		} else {
%>
			<script>
				alert("���� ����");
				history.go(-1);
			</script>
<%
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