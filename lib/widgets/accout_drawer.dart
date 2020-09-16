import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/classes_and_methods/authenticate.dart';
import 'package:frontend/classes_and_methods/user.dart';
import 'package:frontend/widgets/settings.dart';
import 'package:provider/provider.dart';
import 'account.dart';

class AccountDrawer extends StatelessWidget {
  final User user;

  AccountDrawer({Key key, this.user}) : super(key: key);

  get iconSize => null;

  @override
  Widget build(BuildContext context) {
  
     
      return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
        
          
          children: <Widget>[
            DrawerHeader(
              child: Column
              (
                children: <Widget>[
                  Icon(
                     Icons.account_circle,
                     size: 42.0,
                   
                   ),
                Text(user.fullName),
                Text(user.city + ', ' + user.state),
                Text(user.country),
               
                   
            
                

                ]
                  ),
              //const ImageIcon(
              //this.image, {
              // Key key,
              //this.size,
              //this.color,
              //this.semanticLabel,
//}) : super(key: key);
  
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              
            ),
          
            
            ListTile(
              title: Text('Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage(user: user)),
                );
              },
            ),
            ListTile(
              title: Text('Payment Options'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
             ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsOnePage()),
                // Update the state of the app
                // ...
                // Then close the drawer
                );

              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Provider.of<AuthService>(context).logout();
                //Navigator.pop(context);
              },
            ),
          ],
        )
      );  
  
  }
}

