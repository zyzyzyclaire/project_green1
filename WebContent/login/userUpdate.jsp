<%@page import="login.UserBean"%>
<%@page import="login.UserDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	
	UserDBBean db = UserDBBean.getInstance();
	UserBean user = db.getUser(user_id);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    
    
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">	
<script>
		// 도로명 주소 찾기 API 수정 -0421근지
		function goPopup(){
			// 주소검색을 수행할 팝업 페이지를 호출합니다.
			// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
			var pop = window.open("../addrApi/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
			
			// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
		}
		
		function jusoCallBack(roadFullAddr){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			document.upd_frm.user_addr.value = roadFullAddr;
		}
	
		// 입력값 체크 -0421근지
		function update_check_ok(){
			if(document.upd_frm.user_pwd.value.length == 0){
				alert("패스워드는 반드시 입력해야 합니다.");
				document.upd_frm.user_pwd.focus();
				return;
			}	
			
			if(document.upd_frm.user_pwd.value != document.upd_frm.pwd_check.value){
				alert("패스워드가 일치하지 않습니다.");
				upd_frm.pwd_check.focus();
				return;
			}	
			
			if(document.upd_frm.user_email.value.length == 0){
				alert("Email을 써주세요.");
				document.upd_frm.user_email.focus();
				return;
			}
			
			if(document.upd_frm.user_phone.value.length == 0){
				alert("휴대폰번호를 써주세요.");
				document.upd_frm.user_phone.focus();
				return;
			}
			
			if(document.upd_frm.user_addr.value.length == 0){
				alert("주소를 써주세요.");
				document.upd_frm.user_addr.focus();
				return;
			}
			document.upd_frm.submit();
		}
	</script>
<style>
.table{ width: 35%; }
.wrapper{
padding: auto;
margin: 100px 0px; 
margin-left: auto; 
margin-right: auto;
}
</style>
</head>
<body>
<div class="border d-flex justify-content-center" id="hearder_title"> 
    <div class="header_title" >
        <h1><strong>shopping mall</strong></h1>
    </div>
</div>

<div class="wrapper">
 <div style="margin:auto; text-align:center;">
	<h1><label for="floatingInput">회원 정보 수정<br></label>
		<h4>'*' 표시 항목은 필수 입력 항목입니다.</h4>
	</h1>
	<br><br>
	
 <table class="table" align="center">
  <form name="upd_frm" method="post" action="userUpdateOk.jsp" style="display:inline-block;">
	<tr>
		<td><label for="user_id">ID</label></td>
		<td align="left">
				<%= user.getUser_id() %>
		</td>
	</tr>
		
	<tr>
		<td><label for="user_pwd">PASSWORD*</label></td>
		<td>
				<input type="password" size="20" name="user_pwd" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td><label for="pwd_check">암호 확인*</label></td>
		<td>
				<input type="password" size="20" name="pwd_check" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td><label for="user_name">이    름</label></td>
		<td align="left">
				<%= user.getUser_name() %>
		</td>
	</tr>
		
	<tr>
		<td><label for="user_email">E-mail*</label></td>
		<td>
				<input type="text" size="30" name="user_email"
				                    value="<%= user.getUser_email() %>" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td><label for="user_phone">휴대폰 번호</label></td>
		<td>
				<input type="text" size="40" name="user_phone"
				                     value="<%= user.getUser_phone() %>" class="form-control">
		</td>
	</tr>
	
	<tr>
		<td><label for="user_addr">주    소</label></td>
		<td>
				<input type="text" size="40" name="user_addr"
				value="<%= user.getUser_addr()%>" onclick="goPopup()" class="form-control">
		</td>
	</tr>
		<tr align="center">
			<td colspan="4"><br><br>
			
			<input type="reset" value="다시입력" class="btn btn-outline-dark">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="수정" onclick="update_check_ok()" class="btn btn-outline-dark">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="수정안함" onclick="javascript:window.location='../userPage/userPage.jsp'"
			                         class="btn btn-outline-dark">
			</td>
		</tr>
	 </form>
  </table>
 </div>
</div>

</body>
</html>