<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script> <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js">
    </script> <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap-5.1.3-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../fontstyle/fontello-4581031e/css/fontello.css">
    <link rel="stylesheet" href="../css/jquery.bxslider.css">
  <style>
	.wrapper{
		padding: auto;
		margin: 100px 0px; 
		margin-left: auto; 
		margin-right: auto;
	}
	.logindiv{
	    width: 480px;
	    margin: 210px auto;
	    height: 550px;
		border-radius: 20px;
	}
	.wrapper{
		margin: 20px auto;
		max-width : 400px;	
	 	min-width : 400px;	
	 	
	} 
	button.btn {
		background: black;
		color: white;
	}
	
	button.btn:hover{
		background: white;
		color: black;
		border-color: gray;
	}
</style>
<body>
		<div style="border: 1px solid #DCDCDC;" class="logindiv">
	
<div class="wrapper">
 <table align="center" width="400">
  <td colspan="3" class="border_bottom"><h2 align="center" style="color: black; font-size: 25px; font-weight: 500; font-family: Malgun Gothic,����;"">��й�ȣ ã��</h2><br></td>
   <form class="form-horizontal" method="post" action="findPwdOk.jsp">
 
     <div class="form-group">
      <div class="col-sm-10">
       <div class="col-xs-4">
      	<tr>
          <td colspan="3">
      	        <br><div style="color: black; font-size: 15px; font-weight: 500; font-family: Malgun Gothic,����;">����Ͻ� ���̵� �Է��� �ּ���.</div><br>
      		  <input type="text" name="id" class="form-control" id="inputPassword3" placeholder="���̵�" ><br><br>
      	  </td>
      	</tr>
      	
     	<tr>
      	  <td colspan="3">
      	         <div style="color: black; font-size: 15px; font-weight: 500; font-family: Malgun Gothic,����;">����Ͻ� �̸��� �ּҸ� �Է��� �ּ���.</div><br>
      	      <input type="text" name="email" class="form-control" id="inputPassword3" placeholder="E-mail"><br><br><br>
          </td>
      	</tr> 
      </div>
    </div>
  </div>
  
<div class="form-group">
 <div class="col-sm-offset-2 col-sm-10">
  <div class="col-xs-4">
   <tr>
     <td colspan="3">
      	 <button type="submit" class="btn btn-default btn-lg btn-block btn btn-outline-dark" style="font-size: 15px; font-weight: 500; font-family: Malgun Gothic,����;">Ȯ��</button><br><br>  
     </td>
   </tr>
  </div>
 </div>
</div>
  
</form>
</table>
</div> 
</div>
</body>
</html>