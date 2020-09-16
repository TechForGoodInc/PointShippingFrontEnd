import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes_and_methods/authenticate.dart';
import 'classes_and_methods/http_requests.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _username;
  String _password;
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed Login'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      obscureText: false,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(color: Colors.blue),
          labelStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your username!';
        }
        return null;
      },
      onSaved: (input) {
        _username = input;
      },
    );

    final password = TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.blue),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password!';
        }
        return null;
      },
      onSaved: (input) {
        _password = input;
      },
    );

    final loginBtn = MaterialButton(
      onPressed: () {
        final form = _formKey.currentState;
        form.save();
        if (form.validate()) {
          print('Submit form!');
          setState(() {
            _loading = true;
          });
          Provider.of<AuthService>(context)
              .loginUser(_username, _password)
              .then((value) {
            Provider.of<AuthService>(context).getUser().then((value) {
              if (value == null) {
                _showMyDialog();
                setState(() {
                  _loading = false;
                });
              }
            });
          });
        }
      },
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
    );

    final signUpBtn = MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/signup');
      },
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      color: Colors.blue,
    );

      final forgetPassBtn = MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/forgetPass');
      },
      child: Text('Forgot Password',
        style: TextStyle(
          color: Colors.purple[50],
          fontSize: 15,
          ),
      ),
      color: Colors.blue,
    );

    final testBtn = MaterialButton(
      onPressed: () {
        getDataBase().then((value) {
          print(value.statusCode);
          print(value.body);
        });
      },
      child: Text(
        'Test',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      color: Colors.blue,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: new Form(
            key: _formKey,
            child: _loading
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/PS.png',
                          width: 200,
                          height: 200,
                        ),
                        Flexible(flex: 1, child: username),
                        Flexible(flex: 1, child: password),
                        Flexible(flex: 1, child: loginBtn),
                        Flexible(flex: 1, child: signUpBtn),
                        Flexible(flex: 1, child: forgetPassBtn),
                        //testBtn,
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  bool authenticate(String username, String password) {
    return true;
  }
}
