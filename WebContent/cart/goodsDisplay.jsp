<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
// �ӽ÷� ���� ������
	
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
		if(confirm(product_name+" ��/�� ��ٱ��Ͽ� �����ðڽ��ϱ�?")) { 
			location.href = "cartProcess.jsp?product_number="+product_number+"&product_count="+product_count; 
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
	��ǰ ��ȣ : �������� �޾ƿ���<br>
	��ǰ�� :  ������ �ޱ� <br>
	��ǰ ���� :  ������ �ޱ� <br>
	��ٱ��� ��� : <br>
	<input type="button" value="��ٱ��� ���" onclick="cartProcess('<%=product_name%>', '<%=product_number%>', '<%=product_count%>')">
	<br><br>
	��ٱ��� ���� : <br>
	<input type="button" value="��ٱ��� ����" onclick="viewCart()">
</body>
</html>