import 'package:frontend/classes_and_methods/package.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

//'http://52.188.13.210'

//yod*3141

Future<http.Response> createUserPost(Map<String, dynamic> map) async {
  return http.post('http://52.188.13.210/user/', body: map);
}

Future<http.Response> getDataBase() async {
  return http.get('http://52.188.13.210/getdatabase/');
}

Future<http.Response> login(String username, String password) async {
  Map<String, dynamic> userData = {
    'username': username,
    'password': password,
  };

  return http.post(
    'http://52.188.13.210/validate/',
    body: userData,
  );
}

Future<http.Response> postOrderInfo(double amount) {
  Map<String, String> map = {'amount': amount.toString()};
  return http.post('http://52.188.13.210/chargecard/', body: map);
}

Future<Response<dynamic>> getPackageRatesPost(Package package) async {
  // print(package.sender.street1);
  // print(package.sender.street2);
  // print(package.sender.city);
  // print(package.sender.state);
  // print(package.sender.country);
  // print(package.sender.zip);
  // print(package.destination.street1);
  // print(package.destination.street2);
  // print(package.destination.city);
  // print(package.destination.state);
  // print(package.destination.country);
  // print(package.destination.zip);
  // print(package.phone);
  // print(package.weight);
  // print(package.width);
  // print(package.height);
  // print(package.length);
  FormData formData = new FormData.fromMap({
    'origin_add1': package.sender.street1,
    'origin_add2': package.sender.street2,
    'origin_city': package.sender.city,
    'origin_state': package.sender.state,
    'origin_country': package.sender.country,
    'origin_zip': package.sender.zip,
    'origin_phone': package.phone,
    'dest_add1': package.destination.street1,
    'dest_add2': package.destination.street2,
    'dest_city': package.destination.city,
    'dest_state': package.destination.state,
    'dest_country': package.destination.country,
    'dest_zip': package.destination.zip,
    'dest_phone': package.phone,
    'weight': package.weight,
    'width': package.width,
    'height': package.height,
    'length': package.length,
    'tax_payer': 'Sender',
    'insured': 'false',
    'category': 'fashion',
    'currency': 'USD',
    'customs_val': 0,
  });
  print('test2');
  Dio dio = new Dio();
  return await dio.post('http://52.188.13.210/getrates/',
      data: formData,
      options: Options(
        method: 'POST',
        responseType: ResponseType.json,
        sendTimeout: 1000,
      ));
}

Future<http.Response> updateUser(int id, String colname, String replace) async {
  Map<String, dynamic> userData = {
    'id': id.toString(),
    colname: replace,
  };
  print(id);
  print(colname);
  print(replace);
  return http.put(
    'http://52.188.13.210/usermod/' + colname + '/',
    body: userData,
  );
}

Future<http.Response> getPack(Map<String, dynamic> map) async {
  return http.post('http://52.188.13.210/buylabel/', body: map);
}

Future<http.Response> getAllPackages(int userid) async {
  return http
      .get('http://52.188.13.210/getpackages/' + userid.toString() + '/');
}

Future<http.Response> sendEmailLink(Map<String, dynamic> map) async {
  return http.post('http://52.188.13.210/sendlabel/', body: map);
}

Future<http.Response> forgetPass(String username, String email) async {
  Map<String, dynamic> userData = {
    'username': username,
    'email': email,
  };
  print(username);
  print(email);
  return http.post(
    'http://52.188.13.210/identuser/', 
    body : userData,
  );
}

Future<http.Response> sendEmail(String email, int userID) async {
  Map<String, dynamic> userData = {
    'email' : email,
    'userid' : userID.toString(),
  };
  print(email + " correct");
  return http.post(
    'http://52.188.13.210/sendcode/',
    body: userData,
  );
}

Future<http.Response> checkCode(String code, int userID) async {
  //userID = 0;
  Map<String, dynamic> userData = {
    'id' : userID.toString(),
    'code' : code,
  };
  print(code + " checking recovery");
  print(userID);
  return http.post(
    'http://52.188.13.210/recoverycheck/',
    body: userData,
  );
}

