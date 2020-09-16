import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/accout_drawer.dart';
import 'widgets/previous_shipping_labels.dart';
import 'widgets/arkit_scene.dart';

import 'classes_and_methods/user.dart';
import 'classes_and_methods/authenticate.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final bool login = false;
  final User user = null;
  final String username = null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AuthService>(context).getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            key: _scaffoldKey,
            body: Stack(children: [
              /*ARElements(
                user: snapshot.data,
              ),*/
              Positioned(
                  left: 20,
                  bottom: 20,
                  child: Container(
                      child: new IconButton(
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    icon: Icon(Icons.account_circle),
                    color: Colors.blue,
                    iconSize: 72.0,
                  ))),
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                      child: new IconButton(
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                    icon: Icon(Icons.history),
                    color: Colors.blue,
                    iconSize: 72.0,
                  ))),
            ]),
            drawer: new AccountDrawer(
              user: snapshot.data,
            ),
            endDrawer: new PreviousShippingLabelDrawer(
              user: snapshot.data,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
