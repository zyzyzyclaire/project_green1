<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 <script>
   
    	var IMP = window.IMP; // ��������
    	IMP.init('imp92375061');
       //IMP.request_pay(param, callback) 
      IMP.request_pay({ // param
          pg: "kakao",
          pay_method: "card",
          merchant_uid: "100",
       
          name: "�븣���� ȸ�� ����",
          amount: 100, //����
          buyer_email: "gildong@gmail.com",
          buyer_name: "ȫ�浿",
          buyer_tel: "010-4242-4242",
          buyer_addr: "����Ư���� ������ �Ż絿",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
	        	  $.ajax({
		    		  
	  	            url: "test3.jsp", // ��: https://www.myservice.com/payments/complete
	  	            type:"post",
	  	            /* headers: { "Content-Type": "�̰ųѾ��?" }, */
	  	            data:{"check":"ddddddddddddddddd?"},
	  	            success:function(data){	
	  	 				alert("����");
	  	 			},
	  	 			error:function(){
	  	 				alert("����");
	  	 			}
	  	            
	  	        });   
        	  
          } else {
             alert("����");
             
          }
      });
   
  </script>

</head>
<body>
<button onclick="requestPay()">�����ϱ�</button>
<p>

    <p>���� ����Ʈ ���� ��� �׽�Ʈ �غ���</p>
    <button id="check_module" type="button">���� ����Ʈ ���� ��� �׽�Ʈ �غ���</button>
</p>

</body>
</html>