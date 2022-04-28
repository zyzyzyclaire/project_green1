<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 주소 받아올 때 한글 깨지지 않기 위해 -0421근지
	request.setCharacterEncoding("UTF-8");

	String addr = request.getParameter("roadFullAddr");
	if(addr == null) {
		addr = "클릭하여 주소 입력하기";
	}
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
			document.reg_frm.user_addr.value = roadFullAddr;
		}
		
		// 필수입력값 및 패스워드 체크 -0421근지
		function check_ok(){
			if(reg_frm.user_id.value.length == 0){
				alert("아이디를 써주세요.");
				reg_frm.user_id.focus();
				return;
			}
			
			if(reg_frm.user_pwd.value.length == 0){
				alert("패스워드는 반드시 입력해야 합니다.");
				reg_frm.user_pwd.focus();
				return;
			}	
			
			if(reg_frm.user_pwd.value != reg_frm.pwd_check.value){
				alert("패스워드가 일치하지 않습니다.");
				reg_frm.pwd_check.focus();
				return;
			}	
			
			if(reg_frm.user_name.value.length == 0){
				alert("이름을 써주세요.");
				reg_frm.user_name.focus();
				return;
			}
			
			if(reg_frm.user_email.value.length == 0){
				alert("Email을 써주세요.");
				reg_frm.user_email.focus();
				return;
			}
			
			if(reg_frm.user_phone.value.length == 0){
				alert("휴대폰 번호를 써주세요.");
				reg_frm.user_phone.focus();
				return;
			}
			
			if(reg_frm.user_addr.value.length == 0){
				alert("주소를 써주세요.");
				reg_frm.user_addr.focus();
				return;
			}
			
			document.reg_frm.submit();
		}
		
	</script>
<style>
.table{ width: 25%; }
.wrapper{
padding: auto;
margin: 100px 0px; 
margin-left: auto; 
margin-right: auto;
}
.width{width: 170px;}
</style>
</head>

<body>

<div class="wrapper">
 <div style="margin:auto; text-align:center;">
	<h2><label for="floatingInput">회원 가입 신청<br></label>
		<!-- <h4>'*' 표시 항목은 필수 입력 항목입니다.</h4> -->
	</h2>
	<br>
	
 <table class="table" align="center">
  <form name="reg_frm" method="post" action="registerOk.jsp" style="display:inline-block;">
	<tr>
		<td class="width"><label for="user_id">아이디</label></td>
		<td>
				<input type="text" size="50" name="user_id" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td class="width"><label for="user_pwd">비밀번호</label></td>
		<td>
				<input type="password" size="50" name="user_pwd" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td class="width"><label for="pwd_check">비밀번호 중복 확인</label></td>
		<td>
				<input type="password" size="50" name="pwd_check" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td class="width"><label for="user_name">이    름</label></td>
		<td>
				<input type="text" size="50" name="user_name" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td class="width"><label for="user_email">E-mail</label></td>
		<td>
				<input type="text" size="50" name="user_email" class="form-control form-control-sm">
		</td>
	</tr>
		
	<tr>
		<td class="width"><label for="user_phone">휴대폰 번호</label></td>
		<td>
				<input type="text" size="50" name="user_phone" class="form-control">
		</td>
	</tr>
	
	<tr>
		<td class="width"><label for="user_addr">주    소</label></td>
		<td>
				<input type="text" size="80" name="user_addr" onclick="goPopup()" class="form-control">
		</td>
	</tr>
	
	<tr align="center">
		<td colspan="4"><br>
			<input type="reset" value="다시입력" class="btn btn-outline-dark">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="등록" onclick="check_ok()" class="btn btn-outline-dark">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="가입안함" onclick="javascript:window.location='login.jsp'" class="btn btn-outline-dark">
		</td>
	</tr>
   </form>
  </table>
 </div>
</div>

</body>
</html>