import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes_and_methods/authenticate.dart';
import 'classes_and_methods/user.dart';
import 'login_page.dart';

class ForgetPassPage extends StatefulWidget
{
  @override
  _ForgetPassState createState() => _ForgetPassState();
}
class _ForgetPassState extends State<ForgetPassPage> {
  final _formKey = new GlobalKey<FormState>();
  String userName; 
  //User _user;
  bool _loading = false;
  String email;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Either the Username or Email was not found. Please try again!'),
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
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
        child: Text("Forget Password Page", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the username you signed up with to verify your identity!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the email you signed up with to verify your identity!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                    height: 45.0,
                    minWidth: 50.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Continue', style: TextStyle(fontSize: 30, )),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        setState(() {
                          _loading = true;
                        });
                        Provider.of<AuthService>(context).forgetPass(userName, email).then(
                          (value) {
                            print(value);
                            print("1");
                            print(value.country);
                            if(value != null)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EnterCodePage(user: value)));
                            }
                            else
                            {
                              _showMyDialog();
                              setState(() {
                                _loading = false;
                              });
                            }
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => EnterCodePage(user: value)));
                          } 
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class EnterCodePage extends StatefulWidget
{
  final User user;
  EnterCodePage({Key key, this.user}) : super(key: key);
  @override
  _EnterCodeState createState() => _EnterCodeState();
}
class _EnterCodeState extends State<EnterCodePage> {
  final _formKey = new GlobalKey<FormState>();
  String code;
  bool _loading = false;
  User _user = new User();
  void initState() {
    super.initState();
    if (widget.user != null) {
      _user.id = widget.user.id;
      _user.username = widget.user.username;
      _user.email = widget.user.email;
      _user.fullName = widget.user.fullName;
      _user.street = widget.user.street;
      _user.city = widget.user.city;
      _user.state = widget.user.state;
      _user.country = widget.user.country;
      _user.zip = widget.user.zip;
      print(_user.id);
    }
  }
  @override 
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
        child: Text("Enter Confirmation Code From Email", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Code',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the code you received in your email!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        code = value;
                      });
                    },
                  ),
                ),
               Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                    height: 45.0,
                    minWidth: 50.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Submit Code', style: TextStyle(fontSize: 30, )),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        Provider.of<AuthService>(context).verifyCode(code, _user.id).then(
                          (value) {
                            print(value);
                            if(value == "Code Confirmed")
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassPage(user: _user)));
                            }
                          }
                        );
                        setState(() {
                          _loading = true; 
                        });
                        //Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ChangePassPage extends StatefulWidget
{
  final User user;
  ChangePassPage({Key key, this.user}) : super(key: key);
  @override
  _ChangePassState createState() => _ChangePassState();
}
class _ChangePassState extends State<ChangePassPage> {
  final _formKey = new GlobalKey<FormState>();
  String newPassword;
  String newPasswordConfirmed;
  User _user = new User();
  void initState() {
    super.initState();
    if (widget.user != null) {
      _user.id = widget.user.id;
      _user.username = widget.user.username;
      _user.email = widget.user.email;
      _user.fullName = widget.user.fullName;
      _user.street = widget.user.street;
      _user.city = widget.user.city;
      _user.state = widget.user.state;
      _user.country = widget.user.country;
      _user.zip = widget.user.zip;
      print(_user.id);
    }
  }
  @override 
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
        child: Text("Forget Password Page", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'New Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your new password!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      labelText: 'Confirm New Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please confirm your new password correctly!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        newPasswordConfirmed = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                    height: 45.0,
                    minWidth: 50.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Change Password', style: TextStyle(fontSize: 30, )),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        Provider.of<AuthService>(context).updateUser(_user.id, 'password', newPassword).then(
                          (value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          }
                        );
                        //Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}