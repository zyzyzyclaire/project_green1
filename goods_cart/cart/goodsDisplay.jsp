<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//	String user_id = request.getParameter("user_id");
// �ӽ÷� ���� ������
	
	String user_id = "a";
	
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
	function cartProcess(product_name, product_number, user_id, product_count) {
		if(confirm(product_name+" ��/�� ��ٱ��Ͽ� �����ðڽ��ϱ�?")) { 
//			location.href = "cartProcess.jsp"
			location.href = "cartProcess.jsp?product_number="+product_number+"&user_id="+user_id+"&product_count="+product_count; 
		}
	} 
	
	function viewCart(user_id) { 
		if(confirm("��ٱ��ϸ� ���ðڽ��ϱ�?")){ 
			location.href = "viewCart.jsp?user_id="+user_id; 
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
	<input type="button" value="��ٱ��� ���" onclick="cartProcess('<%=product_name%>','<%=product_number%>', '<%=user_id%>', '<%=product_count%>')">
	<br><br>
	��ٱ��� ���� : <br>
	<input type="button" value="��ٱ��� ����" onclick="viewCart('<%=user_id%>')">
</body>
</html>