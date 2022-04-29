<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style type="text/css">
	*{
		font-family: "Malgun Gothic",돋음;
	}
	.nav2{
		margin:auto;
		max-width : 1280px;	
 		min-width : 1120px;	
	}
	
	.nav2div{
		float: right;
	}
</style>
</head>
<body>
	<nav class="nav2" >	
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="nav2div">
		  <ul class="breadcrumb ">
		    <li class="breadcrumb-item"><a href="../main/main.jsp">home</a></li>
		    <li class="breadcrumb-item active" aria-current="page">전체</li>
		  </ul>
		</nav>
			
		<div style="clear: both; font-size: large; color: black;">
			전체
		</div>
		<div class="d-flex justify-content-between"  style="clear: both;  margin-top: 35px; padding-bottom: 10px; border-bottom: 1px rgba(0, 0, 0, 0.09) solid">
			<div class="nav navbox" >
				Total
			</div>
			<div class="nav justify-content-end ulbox">
				판매순
			</div>
		</div>
	</nav>
	
	
</body>
</html>