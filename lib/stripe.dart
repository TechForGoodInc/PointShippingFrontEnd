import 'dart:convert';

import 'package:flutter/material.dart';
import 'classes_and_methods/payment.dart';
import 'classes_and_methods/user.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'classes_and_methods/package.dart';
import 'classes_and_methods/package_label.dart';

class StripePage extends StatefulWidget {
  StripePage({this.package, this.user});

  final EasyPostPackage package;
  final User user;

  @override
  _StripeState createState() => new _StripeState();
}

//stripe key: "pk_live_MpZ63TwhcoDqLHOXXO5y7CfO001A2eOUxl"
class _StripeState extends State<StripePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool _paymentMethodComplete = false;
  //Card card;

  String paymentToken;
  //Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  Future _currentSecret; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  //Source _source;

  @override
  initState() {
    super.initState();
    _currentSecret = PaymentStripe().sendOrderInformation(widget.package.price);
    StripePayment.setOptions(StripeOptions(
        publishableKey: 'pk_test_fmUpeka2eGclxSHraUJV4s3i00XhcnN66H'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
    print(_error);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _paymentIntent == null
              ? () {
                  Navigator.pop(context);
                }
              : null,
        ),
        actions: _paymentIntent == null
            ? <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                  onPressed: () {
                    //Navigator.of(context).push(_confirmSubmit());
                    StripePayment.paymentRequestWithCardForm(
                            CardFormPaymentRequest())
                        .then((paymentMethod) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Received ${paymentMethod.id}')));
                      setState(() {
                        _paymentMethod = paymentMethod;
                        _paymentMethodComplete = true;
                      });
                    }).catchError(setError);
                  },
                )
              ]
            : null,
      ),
      body: Material(
          child: Center(
              child: FutureBuilder(
        future: _currentSecret,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_paymentIntent != null) {
              return Column(
                children: [
                  Text('Payment Complete'),
                  Text('Please check ' +
                      widget.user.email +
                      ' for the postage label.'),
                  RaisedButton(
                    child: Text("Done"),
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 3;
                      });
                      //Navigator.of(context, rootNavigator: true).pop(context);
                    },
                  )
                ],
              );
            }

            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blue,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.mail, size: 70),
                        title: Text(widget.package.courier,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                            '\$' + widget.package.price.toStringAsFixed(2),
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                //Text(snapshot.data.replaceAll(new RegExp('\"'),'')),
                _paymentMethodComplete
                    ? RaisedButton(
                        child: Text("Confirm Payment Intent"),
                        onPressed: _paymentMethod == null ||
                                _currentSecret == null
                            ? null
                            : () {
                                StripePayment.confirmPaymentIntent(
                                  new PaymentIntent(
                                    clientSecret: snapshot.data
                                        .replaceAll(new RegExp('\"'), ''),
                                    paymentMethodId: _paymentMethod.id,
                                  ),
                                ).then((paymentIntent) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          'Received ${paymentIntent.paymentIntentId}')));
                                  print(paymentIntent.status);
                                  addPackage(widget.package, widget.user.id)
                                      .then((value) {
                                    print('adding:' + value.toString());
                                    var label = json.decode(value);
                                    print(label['label']);
                                    sendLabel(widget.user.email, label['label'])
                                        .then((value) {
                                      print('email:' +
                                          value.statusCode.toString());
                                    });
                                  });

                                  setState(() {
                                    _paymentIntent = paymentIntent;
                                  });
                                }).catchError(setError);
                              },
                      )
                    : Text('Add payment method!'),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ))),
    );
  }
}
