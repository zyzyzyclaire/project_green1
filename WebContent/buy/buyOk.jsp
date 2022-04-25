<%@page import="buy.UserOrderDetailDBBean"%>
<%@page import="buy.UserOrderDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>   
<jsp:useBean id="userOrder" class="buy.UserOrderBean"/>
<jsp:setProperty property="*" name="userOrder"/>
<jsp:useBean id="userOrderDetail" class="buy.UserOrderDetailBean"/>
<jsp:setProperty property="*" name="userOrderDetail"/>
<%
	// buy.jsp���� submit�� �� �ǳʿ��� ���� ���� ����(UserOrder��) -0422����
	String user_id = (String)session.getAttribute("user_id");
	userOrder.setUser_id(user_id);
	
	Timestamp now = new Timestamp(System.currentTimeMillis());
	userOrder.setOrder_date(now);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		UserOrderDBBean order_db = UserOrderDBBean.getInstance();
		UserOrderDetailDBBean detail_db = UserOrderDetailDBBean.getInstance();
	
		// buy.jsp���� submit�� �� �ǳʿ��� ���� ���� ����(UserOrderDetail��) -0425����
		
		// order_number�� ã�� -0425����
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String time = sdf.format(now);
		String order_number = time+"_"+user_id;
		userOrderDetail.setOrder_number(order_number);
		
	%>
	<%
		if(order_db.insertUserOrder(userOrder) == 1 && detail_db.insertUserOrderDetail(userOrderDetail) == 1) {
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