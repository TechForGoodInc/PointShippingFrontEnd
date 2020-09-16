import 'dart:convert';

import 'package:frontend/classes_and_methods/package.dart';
import 'http_requests.dart' as httpr;

Future<List> getPackageRates(Package package) async {
  print('test');
  return await httpr.getPackageRatesPost(package).then((value) {
    var rates = value.data['rates'];
    print(value.statusCode);
    print(value.data);
    if (rates.length > 0) {
      return Future.value(rates);
    } else {
      return Future.value(null);
    }
  });
}

Future<String> addPackage(EasyPostPackage easypackage, int userid) async {
  print(easypackage.shipmentId);
  print(easypackage.rateId);
  Map<String, String> map = {
    'user_id': userid.toString(),
    'shipment_id': easypackage.shipmentId,
    'rate_id': easypackage.rateId,
    // 'platform_order_number': '#1',
    // 'dest_name': easypackage.package.destination.name,
    // 'dest_add1': easypackage.package.destination.street1,
    // 'dest_add2': '',
    // 'dest_city': easypackage.package.destination.city,
    // 'dest_state': easypackage.package.destination.state,
    // 'dest_zip': easypackage.package.destination.zip.toString(),
    // 'dest_country': easypackage.package.destination.country,
    // 'dest_phone': '+1 206-867-5309',
    // 'dest_email': 'ecl.damoose@gmail.com',
    // 'item_description': 'cat rain boots',
    // 'weight': 15.23.toString(),
    // 'height': 12.5.toString(),
    // 'width': 6.5.toString(),
    // 'length': 12.toString(),
    // 'category': 'fashion',
    // 'currency': 'USD',
    // 'customs_val': 35.01.toString(),
  };

  return await httpr.getPack(map).then((value) {
    return value.body;
  });
}

Future getHistoricalData(int userid) async {
  return httpr.getAllPackages(userid).then((value) {
    print(value.statusCode);
    //var resp = json.decode(value.body);

    return json.decode(value.body)['packages'];

    // for (int i = 0; i < resp.length; i++) {
    //   var respIndex = resp[i];
    //   print('test:' + i.toString());
    //   print(respIndex);
    //   // EasyPostPackage temp = new EasyPostPackage(
    //   //   package: Package(
    //   //       width: respIndex['box']['width'],
    //   //       height: respIndex['box']['height'],
    //   //       length: respIndex['box']['length'],
    //   //       weight: respIndex['box']['weight'],
    //   //       sender: Address(
    //   //         name: respIndex['origin_address:']['contact_name'],
    //   //         street: respIndex['origin_address']['line_2'],
    //   //         city: respIndex['origin_address']['city'],
    //   //         state: respIndex['origin_address']['state'],
    //   //         country: respIndex['origin_country']['alpha2'],
    //   //         zip: respIndex['origin_address']['postal_code'],
    //   //       ),
    //   //       destination: Address(
    //   //         name: respIndex['destination_name'],
    //   //         street: respIndex['destination_address_line_1'],
    //   //         city: respIndex['destination_city'],
    //   //         state: respIndex['destination_state'],
    //   //         country: respIndex['destination_country']['alpha2'],
    //   //         zip: respIndex['destination_postal_code'],
    //   //       )),
    //   //   courier: respIndex['selected_courier']['name'],
    //   //   courierId: respIndex['selected_courier']['id'],
    //   //   date: respIndex['selected_courier']['max_delivery_time'],
    //   //   price: respIndex['selected_courier']['total_charge'],
    //   // );
    //   print('test2');
    //   previous.add(temp);
    // }
    //print('test:return');
  });
  //return previous;
}

Future sendLabel(String email, String url) async {
  Map<String, String> map = {
    'email': email,
    'url': url,
  };

  return httpr.sendEmailLink(map).then((value) {
    print(value.body);
    return value;
  });
}
