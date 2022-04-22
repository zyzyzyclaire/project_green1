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
</head>
<body>
	<table border="1">
		<form name="reg_frm" method="post" action="registerOk.jsp">
			<tr>
				<td colspan="2" align="center">
					<h1>회원 가입 신청</h1>
					'*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td width="80">
					ID
				</td>
				<td>
					<input type="text" size="20" name="user_id">*
				</td>
			</tr>
			<tr>
				<td width="80">
					PASSWORD
				</td>
				<td>
					<input type="password" size="20" name="user_pwd">*
				</td>
			</tr>
			<tr>
				<td width="80">
					PASSWORD 중복 확인
				</td>
				<td>
					<input type="password" size="20" name="pwd_check">*
				</td>
			</tr>
			<tr>
				<td width="80">
					이    름
				</td>
				<td>
					<input type="text" size="20" name="user_name">*
				</td>
			</tr>
			<tr>
				<td width="80">
					E-mail
				</td>
				<td>
					<input type="text" size="30" name="user_email">*
				</td>
			</tr>
			<tr>
				<td width="80">
					휴대폰 번호
				</td>
				<td>
					<input type="text" size="40" name="user_phone">*
				</td>
			</tr>
			<tr>
				<td width="80">
					주    소
				</td>
				<td>
					<input type="text" size="40" name="user_addr" onclick="goPopup()">*
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="등록" onclick="check_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="가입안함" onclick="javascript:window.location='login.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>