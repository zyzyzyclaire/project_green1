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
$("#check_module").click(function () {
var IMP = window.IMP; // ��������
IMP.init('imp92375061');

IMP.request_pay({
pg: 'kakao', 

pay_method: 'card',
/*
'samsung':�Ｚ����,
'card':�ſ�ī��,
'trans':�ǽð�������ü,
'vbank':�������,
'phone':�޴����Ҿװ���
*/
merchant_uid: 'merchant_' + new Date().getTime(),
/*
merchant_uid�� ���
https://docs.iamport.kr/implementation/payment
���� url�� ���󰡽ø� ���� �� �ִ� ����� �ֽ��ϴ�.
�����ϼ���.
���߿� ������ �غ��Կ�.
*/
name: '�ֹ���:�����׽�Ʈ',
//����â���� ������ �̸�
amount: 1000,
//����
buyer_email: 'iamport@siot.do',
buyer_name: '�������̸�',
buyer_tel: '010-1234-5678',
buyer_addr: '����Ư���� ������ �Ｚ��',
buyer_postcode: '123-456',
m_redirect_url: 'https://www.yourdomain.com/payments/complete'
/*
����� ������,
������ ������ �����Ǵ� URL�� ����
(īī������, ������, �ٳ��� ���� �ʿ����. PC�� ���������� callback�Լ��� ����� ������)
*/
}, function (rsp) {
console.log(rsp);
if (rsp.success) {
var msg = '������ �Ϸ�Ǿ����ϴ�.';
msg += '����ID : ' + rsp.imp_uid;
msg += '���� �ŷ�ID : ' + rsp.merchant_uid;
msg += '���� �ݾ� : ' + rsp.paid_amount;
msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;
} else {
var msg = '������ �����Ͽ����ϴ�.';
msg += '�������� : ' + rsp.error_msg;
}
alert(msg);
});
});
</script>

 <script>
    function requestPay() {
    	var IMP = window.IMP; // ��������
    	IMP.init('imp92375061');
       //IMP.request_pay(param, callback) 
      IMP.request_pay({ // param
          pg: "kakao",
          pay_method: "card",
          merchant_uid: "55",
       
          name: "�븣���� ȸ�� ����",
          amount: 1, //����
          buyer_email: "gildong@gmail.com",
          buyer_name: "ȫ�浿",
          buyer_tel: "010-4242-4242",
          buyer_addr: "����Ư���� ������ �Ż絿",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
          if (rsp.success) {
             
          } else {
             
          }
      });
    }
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