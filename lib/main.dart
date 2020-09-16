import 'package:flutter/material.dart';
import 'forget_pass.dart';
import 'package:provider/provider.dart';
//import 'package:frontend/widgets/theme_changer.dart';
import 'classes_and_methods/authenticate.dart';
import 'classes_and_methods/user.dart';

import 'home_page.dart';
import 'signup_page.dart';
import 'login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AuthService>(
      child: MyApp(),
      builder: (BuildContext context) {
        return AuthService();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  final User user = null;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //return ThemeBuilder(
    //defaultBrightness: Brightness.dark,
    //builder: (context, _brightness) {
    return MaterialApp(
        title: 'Point Shipping',
        theme: ThemeData(primarySwatch: Colors.blue), //brightness: _brightness
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => new SignUpPage(),
          '/home': (BuildContext context) => new HomePage(),
          '/forgetPass': (BuildContext context) => new ForgetPassPage(),
          //'/secondsignup': (BuildContext context) => new SecondSignUpPage(),
        },
        home: FutureBuilder(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.hasData ? HomePage() : LoginPage();
            }
            return CircularProgressIndicator();
          },
        ));
  }
  //);
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// abstract class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     ThemeBuilder.of(context).changeTheme();
//     setState(() {
//       _counter++;
//     });
//   }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _dark;

//   @override
//   void initState() {
//     super.initState();
//     _dark = false;
//   }

//   Brightness _getBrightness() {
//     return _dark ? Brightness.dark : Brightness.light;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//         isMaterialAppTheme: true,
//         data: ThemeData(
//           brightness: _getBrightness(),
//         ),
//         child: Scaffold(
//             backgroundColor: _dark ? null : Colors.grey.shade200,
//             appBar: AppBar(
//               elevation: 0,
//               brightness: _getBrightness(),
//               iconTheme:
//                   IconThemeData(color: _dark ? Colors.white : Colors.black),
//               backgroundColor: Colors.transparent,
//               title: Text(
//                 'Point Shipping',
//                 style: TextStyle(color: _dark ? Colors.white : Colors.black),
//               ),
//               actions: <Widget>[
//                 IconButton(
//                   icon: Icon(FontAwesomeIcons.moon),
//                   onPressed: () {
//                     setState(() {
//                       _dark = !_dark;
//                     });
//                   },
//                 )
//               ],
//             )));
//   }
// }
