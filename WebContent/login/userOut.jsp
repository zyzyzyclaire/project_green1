<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String user_id = null;
    
    
	if(((String)session.getAttribute("user_id"))!=null){
		user_id =(String)session.getAttribute("user_id");
		
	}
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<style>
		#regidiv{
			
			margin:auto;
		   	min-width : 500px;	
			max-width : 600px;	
			height: 400px;
			
		}
		.width_tr{
			width: 200px;
			height: 30px;
			
		}
		.title_tr{
			width: 1000px;
			height: 15px;
		 	font-weight: bold;
		 	font-family: "Nanum Gothic","Malgun Gothic","���� ���","����","Dotum","Apple Gothic","Apple SD Gothic Neo",sans-serif;
		 	
		 	
		}
		input.btn {
			background: black;
			color: white;
		}
		
		input.btn:hover{
			background: white;
			color: black;
			border-color: gray;
		}
		input.btn1{
			background:	#A9A9A9;
			color: white;
		}
		input.btn1:hover{
			background: white;
			color: black;
			border-color: gray;
		}
	</style>
	
</head>
<body>
     <jsp:include page="../main/mainHeader.jsp"></jsp:include> 
	<hr>    

<!-- <div class="regidiv"> -->
	<table class="table" id="regidiv" style="font-size: 15px;">
		<form method="post" action="userOutOk.jsp" >
			<tr class="title_tr">
				<td colspan="2" style="vertical-align : bottom; border: solid 2px white;"> 
					<div style="font-size: 25px;">ȸ�� Ż��</div><br>
				</td>
				
				<td class="regitd2" style="vertical-align : bottom; border: solid 2px white;">
					<div align="right" style="font-size: 15px;">'*'�ʼ� �Է� ����</div>
				</td> 
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; border-top: solid 3px #DCDCDC; background-color: #F5F5F5;">
					&nbsp;&nbsp;���̵�
				</td>
				

				<td colspan="2" style="vertical-align: middle; border-top: solid 3px #DCDCDC;" id="boderright" >
  					<div class="col-5">
   						<%= user_id %>
					<!-- <input type="text" size="20" name="user_id">* -->
					</div>
				</td>
			</tr>
			<tr>
				<td width="80" class="width_tr" id="boderleft" style="vertical-align: middle; background-color: #F5F5F5;" >
					&nbsp;&nbsp;��й�ȣ*
				</td>
				<td colspan="2" style="vertical-align: middle;" id="boderright">
				  <div class="col-8">
					<input type="password" size="20" name="user_pwd" class="form-control" style="font-size: 15px; font: 500; font-family: Malgun Gothic,����;">
				  </div>
				</td>
			</tr>
			
			<tr class="title_tr">
				<td colspan="3" align="center" style="vertical-align: middle; border-bottom: none;">
					<input type="submit" value="Ż  ��" class="btn btn-outline-dark" style="font-size: 15px; font: 500; font-family: Malgun Gothic,����;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="Ż�����" onclick="javascript:window.location='../userPage/userPage.jsp'" class="btn btn-outline-gray btn1"
													style="font-size: 15px; font: 500; font-family: Malgun Gothic,����;">
				</td>
			</tr>
		</form>
	</table>

<!-- </div> -->
 <br><br><br><br>
	<jsp:include page="../main/mainfooter.jsp"></jsp:include>  
	
</body>
</html>
