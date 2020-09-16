import 'http_requests.dart' as httpr;


class PaymentStripe {


  Future<String> sendOrderInformation(double amount) async {
    return await httpr.postOrderInfo(amount).then(
      (value) {
        print(value.body);
        return value.body; 
      }
    );
  }

}

// Future<String> sendCardPOST(String cardNum, String date, String cvc, String customerId) async {
//   //print('test');
//   //var dates = date.split('/');
//   //print(dates[0]);
//   await httpr.sendCard(cardNum, '04', '24', cvc, customerId).then((value) {
//     if (value.statusCode == 200) {
//       print(value.body);
//       return '';
//     } else {
//       return ''; 
//     }
//   });
//   return '';
// }

// // Future payment(String paymentToken, double amount) async {
// //   // await httpr.pay(paymentToken, amount).then(
// //   //   (value) {
// //   //     if (value.statusCode == 200) {
// //   //       return 1; 
// //   //     } else {
// //   //       return 0;
// //   //     }
// //   //   }
// //   // );

// }