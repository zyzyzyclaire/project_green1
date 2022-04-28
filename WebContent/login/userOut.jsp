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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    
    
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700"> 
    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/magnific-popup.css">
    <link rel="stylesheet" href="../css/jquery-ui.css">
    <link rel="stylesheet" href="../css/owl.carousel.min.css">
    <link rel="stylesheet" href="../css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../css/aos.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/custom2.css"> -->
<style>
.table{ width: 25%; }
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
	<h1><label for="floatingInput">회원 탈퇴<br></label></h1>
	<br><br>
	
 <table class="table" align="center">
  <form method="post" action="userOutOk.jsp" style="display:inline-block;">
	<tr>
		<td><label for="user_id">ID</label></td>
		<td align="left">
				<%= user_id %>
		</td>
	</tr>
		
	<tr>
		<td><label for="user_pwd">PASSWORD*</label></td>
		<td>
			<input type="password" size="20" name="user_pwd" class="form-control form-control-sm">
		</td>
	</tr>
		
		
		
		<tr align="center">
			<td colspan="4"><br><br>
					<input type="submit" value="탈퇴" class="btn btn-outline-dark">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="탈퇴안함" onclick="javascript:window.location='../userPage/userPage.jsp'"
					             class="btn btn-outline-dark">
			</td>
		</tr>
   </form>
  </table>
 </div>
</div>

</body>
</html>