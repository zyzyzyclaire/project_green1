<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function(){
	  
	  $('#main_menu > li > a').click(function(){
	    $(this).next($('.snd_menu')).slideToggle('fast');
	  })

	  // ��ư Ŭ�� �� �� ����
	  $('li > a').focus(function(){
	    $(this).addClass('selec');
	  })
	  $("li > a").blur(function(){
	    $(this).removeClass('selec');
	  })
	  
	})
</script>
<style>
	nav {
  		width: 150px;
	}
	
	ul { padding: 0; 
  	}
  		 
	li {
 		 list-style: none;
  		 line-height: 34px;
  		 float: left;
	}
	
	a {
	  display: block; /* �߿� */
	  text-decoration: none;
	  color: #616161;
	  text-align: center;
	}
	
	.snd_menu { background: #efefef; }
	.sub_menu { display: none; } /* ����޴��� ���� */
	.selec { background: #c45; color: #efefef; }
</style>
<title>�Խ��ǰ���</title>
</head>
<body>
	<nav>
		<a class="nav-link" href="../adminPage/adminPage.jsp"><span></span>����������</a>
	</nav>
	
	<h2>�Խ��ǰ���</h2>
	<hr><br>
	<nav>
	  <ul id="main_menu">
	      <li><a href="#">�������� ����</a>
	        <ul class="snd_menu sub_menu">
	          <li><a href="../customer_service/notice_write.jsp">�������� ���</a></li>
	          <li><a href="../customer_service/notice_list.jsp">�������� ����/����</a></li>
   	       </ul>
	      </li>
	      <li><a href="#">QnA �Խ��� ����</a>
	        <ul class="snd_menu sub_menu">
	          <li><a href="../customer_service/.jsp">QnA �Խ��� ���ϱ�</a></li>
	          <li><a href="../customer_service/qnaList.jsp">�Խñ� ����/����</a></li>
   	       </ul>
	      </li>
	  </ul>
	</nav>
</body>
</html>