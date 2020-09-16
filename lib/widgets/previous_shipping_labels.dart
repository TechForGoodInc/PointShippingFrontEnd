import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/checkout_page.dart';
import 'package:frontend/classes_and_methods/package.dart';
import 'package:frontend/classes_and_methods/user.dart';
import 'package:frontend/classes_and_methods/package_label.dart';

final List<String> carrierNames = <String>["USPS", "UPS", "Fedex"];
final List<String> sourceDes = <String>[
  "Los Angeles",
  "Seattle",
  "Philidelphia"
];
final List<String> finalDes = <String>["Miami", "Salt Lake City", "Vancouver"];
final List<int> colorCodes = <int>[600, 500, 100];
final List<int> prices = <int>[25, 15, 30];
final List<String> dates = <String>["5/15/20", "4/23/20", "4/5/20"];
final List<String> dimensions = <String>[
  "10 cm x 20 cm x 18 cm",
  "15 cm x 7 cm x 25 cm",
  "3 cm x 5 cm x 9 cm"
];
final List<String> imageNames = <String>[
  "usps-logo.png",
  "ups-logo.png",
  "FedEx-logo.png"
];

class PreviousShippingLabelDrawer extends StatefulWidget {
  PreviousShippingLabelDrawer({Key key, this.user}) : super(key: key);

  final User user;

  _PreviousShippingLabelDrawerState createState() =>
      _PreviousShippingLabelDrawerState();
}

class _PreviousShippingLabelDrawerState
    extends State<PreviousShippingLabelDrawer> {
  Widget buildPage() {
    return FutureBuilder(
        future: getHistoricalData(widget.user.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Retrieving Package Data...'),
                  CircularProgressIndicator()
                ],
              ),
            ));
          } else {
            //var previous = snapshot.data;
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data[index]['to_zip']);
                  var resp = snapshot.data[index];
                  Package prevPackage = new Package(
                    phone: resp['from_phone'],
                    height: resp['height'],
                    width: resp['width'],
                    length: resp['length'],
                    weight: resp['weight'],
                    sender: Address(
                        name: resp['from_name'],
                        street1: resp['from_street1'],
                        street2: resp['from_street2'],
                        city: resp['from_city'],
                        state: resp['from_state'],
                        country: resp['from_country'],
                        zip: resp['from_zip']),
                    destination: Address(
                        name: resp['to_name'],
                        street1: resp['to_street1'],
                        street2: resp['to_street2'],
                        city: resp['to_city'],
                        state: resp['to_state'],
                        country: resp['to_country'],
                        zip: resp['to_zip']),
                  );
                  String imagePath;
                  switch (carrierNames[index]) {
                    case 'USPS - Parcel Select':
                    case 'USPS - Priority Mail Express':
                    case 'USPS - Parcel Select Express':
                    case 'USPS':
                      {
                        imagePath = 'assets/usps-logo.png';
                        break;
                      }
                    case 'Fedex':
                      {
                        imagePath = 'assets/FedEx-logo.png';
                        break;
                      }
                    case 'UPS':
                      {
                        imagePath = 'assets/ups-logo.png';
                        break;
                      }
                    default:
                      imagePath = 'assets/usps-logo.png';
                  }
                  if (index == 0) {
                    return DrawerHeader(
                      child: Center(
                          child: Text(
                        'History',
                        textScaleFactor: 2.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    );
                  }
                  index -= 1;
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(_confirmSubmit(prevPackage));
                    },
                    leading: Image.asset(
                      imagePath,
                      width: 40,
                      height: 40,
                    ),
                    title: Text(prevPackage.sender.city +
                        ' to ' +
                        prevPackage.sender.city),
                    subtitle: Text(prevPackage.weight.toStringAsFixed(2) +
                        'lbs' +
                        prevPackage.width.toStringAsFixed(2) +
                        ' x ' +
                        prevPackage.height.toStringAsFixed(2) +
                        ' x ' +
                        prevPackage.length.toStringAsFixed(2)),
                    isThreeLine: true,
                  );
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: buildPage());
  }

  Route _confirmSubmit(Package package) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CheckOutPage(
        previousPackage: true,
        package: package,
        user: widget.user,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

// InkWell(
//   onTap: () {
//     print("Tapped a container");
//   },
//   child: Container(
//     height: 250,
//     color: Colors.amber[colorCodes[index]],
//     child: Center(child: Column(
//       children: <Widget>[
//       Image(height: 150, width: 150, image: AssetImage(imageNames[index])),
//       Text('Postal Service: ${carrierNames[index]}'),
//       Text('Source Destination: ${sourceDes[index]}'),
//       Text('Final Destination: ${finalDes[index]}'),
//       Text('Price: \$${prices[index]}'),
//       Text('Date: ${dates[index]}'),
//       Text('Dimensions: ${dimensions[index]}')]
//       )
//     )
//   ),
// );

// FutureBuilder(
//   future: ,
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.done) {
//       return

//     } else {
//       return CircularProgressIndicator();
//     }
//   },
