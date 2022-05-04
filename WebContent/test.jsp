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
   
    	var IMP = window.IMP; // 생략가능
    	IMP.init('imp92375061');
       //IMP.request_pay(param, callback) 
      IMP.request_pay({ // param
          pg: "kakao",
          pay_method: "card",
          merchant_uid: "100",
       
          name: "노르웨이 회전 의자",
          amount: 100, //가격
          buyer_email: "gildong@gmail.com",
          buyer_name: "홍길동",
          buyer_tel: "010-4242-4242",
          buyer_addr: "서울특별시 강남구 신사동",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
	        	  $.ajax({
		    		  
	  	            url: "test3.jsp", // 예: https://www.myservice.com/payments/complete
	  	            type:"post",
	  	            /* headers: { "Content-Type": "이거넘어가냐?" }, */
	  	            data:{"check":"ddddddddddddddddd?"},
	  	            success:function(data){	
	  	 				alert("성공");
	  	 			},
	  	 			error:function(){
	  	 				alert("실패");
	  	 			}
	  	            
	  	        });   
        	  
          } else {
             alert("실패");
             
          }
      });
   
  </script>

</head>
<body>
<button onclick="requestPay()">결제하기</button>
<p>

    <p>아임 서포트 결제 모듈 테스트 해보기</p>
    <button id="check_module" type="button">아임 서포트 결제 모듈 테스트 해보기</button>
</p>

</body>
</html>