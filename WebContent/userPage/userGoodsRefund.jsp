<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script src="../js/jquery.js"></script>
<script type="text/javascript">
	function refund(order_detail_number) {
		if(confirm("ȯ�ҽ�û�Ͻðڽ��ϱ�?")){
			$.ajax({
	   			url:"./userGoodsRefundOk.jsp",
	   			type:"post",
	   			data:{"order_detail_number":order_detail_number},
	   			//data:{"search":send,"zipcode":"12345"},
	   			//dataType,
	   			success:function(data){	
	   				location.href="userPage.jsp";
	   				//document.getElementById("main_stat_point2").innerHTML =data;
	   			},
	   			error:function(){
	   				alert("����");
	   				//document.getElementById("main_stat_point2").innerHTML ="<h3>d fail</h3>";
	   			}
	   		});
		}
	}
	
	
</script>
<body>
	<%
		int order_detail_number = Integer.parseInt( request.getParameter("order_detail_number"));
	
	%>
	<input type="button" onclick="refund(<%=order_detail_number%>)" value="ȯ�ҽ�û">
	
</body>
</html>