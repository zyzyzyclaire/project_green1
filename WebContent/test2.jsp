<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
 <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-{SDK-�ֽŹ���}.js"></script>
  <script type="text/javascript">
	
  </script>
  
  <script>
    function requestPay() {
    	  var IMP = window.IMP; // ���� ����
    	  IMP.init("imp92375061"); // ��: imp00000000
      // IMP.request_pay(param, callback) ����â ȣ��
      IMP.request_pay({ // param
          pg: "html5_inicis",
          pay_method: "card",
          merchant_uid: "ORD20180131-0000011",
          name: "�븣���� ȸ�� ����",
          amount: 64900,
          buyer_email: "gildong@gmail.com",
          buyer_name: "ȫ�浿",
          buyer_tel: "010-4242-4242",
          buyer_addr: "����Ư���� ������ �Ż絿",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
              ...,
              // ���� ���� �� ����,
              ...
          } else {
              ...,
              // ���� ���� �� ����,
              ...
          }
      });
    }
  </script>
</head>
<body>
 <button onclick="requestPay()">�����ϱ�</button>
</body>
</html>