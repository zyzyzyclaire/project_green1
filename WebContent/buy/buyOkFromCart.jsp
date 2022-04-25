<%@page import="java.text.SimpleDateFormat"%>
<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<%
	// buyFromCart.jsp���� submit�� �� �ǳʿ��� ���� ���� ����(UserOrder��) -0422����
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<%
	// ���� �޼��带 ���� ����(UserOrderDetail��) -0425����
	
	UserOrderDBBean order_db = UserOrderDBBean.getInstance();
	UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();

	// order_number�� ã�� -0425����
	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	String time = sdf.format(now);
	String order_number = time+"_"+user_id;
	
	// cart_number �迭 �ޱ� -0425����
	String[] cart_num_arr = request.getParameterValues("cart_num_arr");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
		<%
		if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetailArray(cart_num_arr, order_number) == 1) {
	%>		
			<script type="text/javascript">
			alert("�ֹ� ����. �Ա� �� �߼��� ���۵˴ϴ�.");
			location.href="../main/main.jsp";
			</script>
	<%
		} else {
	%>
				<script>
				alert("�ֹ� ����. �ٽ� �õ����ּ���.");
				history.back();
				</script>
	<%	
		}
	%>
</body>
</html>