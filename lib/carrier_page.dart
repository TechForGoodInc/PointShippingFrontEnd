import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classes_and_methods/package.dart';
import 'classes_and_methods/package_label.dart';
import 'stripe.dart';
import 'classes_and_methods/user.dart';

class CarrierPage extends StatefulWidget {
  CarrierPage({this.package, this.user});

  final Package package;
  final User user;

  _CarrierPageState createState() => _CarrierPageState();
}

class _CarrierPageState extends State<CarrierPage> {
  var list;

  void initState() {
    super.initState();
    list = getPackageRates(widget.package);
  }

  Widget buildPage() {
    return FutureBuilder(
      future: list,
      builder: (BuildContext build, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data[index]);
                EasyPostPackage temp = new EasyPostPackage(
                    package: widget.package,
                    courier: snapshot.data[index]['carrier'],
                    price: double.parse(snapshot.data[index]['list_rate']),
                    courierId: snapshot.data[index]['carrier_account_id'],
                    date: snapshot.data[index]['delivery_days'],
                    shipmentId: snapshot.data[index]['shipment_id'],
                    rateId: snapshot.data[index]['id']);

                String imagePath;
                Align(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.amber[600],
                      width: 48.0,
                      height: 48.0,
                      child: Text(
                        temp.price.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.redAccent[700],
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto"),
                      )),
                );
                switch (temp.courier) {
                  case 'USPS - Parcel Select':
                  case 'USPS - Priority Mail Express':
                  case 'USPS - Parcel Select Express':
                    {
                      imagePath = 'assets/usps-logo.png';
                      break;
                    }

                  case 'FedEx':
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
                return Card(
                    child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(_confirmSubmit(temp));
                        },
                        leading: Image.asset(
                          imagePath,
                          width: 40,
                          height: 40,
                        ),
                        title: Text('\$' + temp.price.toStringAsFixed(2)),
                        subtitle:
                            Text(temp.date.toString() + ' day delivery')));
              });
        } else {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('Loading rates...'),
                CircularProgressIndicator(),
              ]));
        }
      },
    );
  }

  Route _confirmSubmit(EasyPostPackage package) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => StripePage(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: buildPage());
  }
}
