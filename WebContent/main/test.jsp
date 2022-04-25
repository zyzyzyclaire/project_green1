<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>


<script>
var arrInput = new Array(0);
  var arrInputValue = new Array(0);
 
function addInput() {
  arrInput.push(arrInput.length);
  arrInputValue.push("");
  display();
}
 
function display() {
  document.getElementById('parah').innerHTML="";
  for (intI=0;intI<arrInput.length;intI++) {
    document.getElementById('parah').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
  }
}
 
function saveValue(intId,strValue) {
  arrInputValue[intId]=strValue;
}  
 
function createInput(id,value) {
	//alert("@@>"+(id+1));
  return "<tr><td><input type='file' id='test "+ (id+1) +"' onChange='javascript:saveValue("+ id +",this.value)' value='"+ 
   value +"'  name='product_img"+(id+1)+"'></td></tr><br>";
}
 
function deleteInput() {
  if (arrInput.length > 0) { 
     arrInput.pop(); 
     arrInputValue.pop();
  }
  display(); 
}
</script>
</head>
<body>
	<form method="post" action="test2.jsp">
		
		<table id="parah" border="1">
			
		</table>
		<input type="button" value="추가" onclick="addInput();" />
		<input type="button" value="삭제" onclick="deleteInput();"/>
		<input type="submit" value="전송"/>
	</form>


</body>
</html>