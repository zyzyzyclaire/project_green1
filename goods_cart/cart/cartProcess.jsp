<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	String user_id = request.getParameter("user_id");
	int product_count = Integer.parseInt(request.getParameter("product_count"));

	
	
	// ȸ���� �ƴ� ���� ��ٱ��� ����� �Ұ����� - 0418 ����
	if(user_id.equals("null")) {	// ������Ʈ������ �Ѿ�ͼ� ���ڿ� null�� Ȯ�� -0418����
%>
		<script>
			alert("ȸ���� ��ٱ��� ����� �����մϴ�.");
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
			alert("��ٱ��� ���� �Ϸ�.");
			history.back();
			</script>
	<%
		} else {
	%>
				<script>
				alert("��ٱ��� ���� �����߽��ϴ�.");
				document.location.href="goodsDisplay.jsp";
				</script>
	<%	
		}
	%>
</body>
</html>