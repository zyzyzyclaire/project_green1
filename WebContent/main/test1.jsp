<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<SCRIPT LANGUAGE="JavaScript">

cnt=0;
function input_append(ff){
  cnt++;
  app = document.getElementById("append");
  app.innerHTML += cnt + " :< <input type=file name=txt"+cnt+"><br>";
}



</SCRIPT>


<body>

</p>
<form name="frm1" method="post" action="">
	<input type="button" value="input �±� �߰�" onclick="input_append(this.form)">
	<div id="append" ></div>
	<input type="submit" value="����">
	
</form>


</body>
</html>