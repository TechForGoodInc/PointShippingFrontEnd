import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/classes_and_methods/user.dart';
import 'package:provider/provider.dart';
import 'package:frontend/classes_and_methods/authenticate.dart';
class AccountPage extends StatefulWidget
{
  final User user;
  AccountPage({Key key, this.user}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}
//have to retain other settings that the user doesn't update
class _AccountState extends State<AccountPage> {
  final _formKey = new GlobalKey<FormState>();
  String userName; 
  String fullName;
  String email;
  String streetAddress;
  String city;
  String stateName;
  String country;
  int zipCode;
  //User user = new User(user);
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
      //print(_user.email);
    }
  }
  //String password;
  @override 
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
        child: Text("Update Account Information", 
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
                //remember to add an ability to select a profile picture
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  child: Divider(),
                ),*/
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                MaterialButton(
                    height: 50.0,
                    minWidth: 45.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Update', style: TextStyle(fontSize: 30, )),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        Provider.of<AuthService>(context).updateUser(_user.id, 'sender', fullName).then(
                          (value) {

                          }
                          
                        );
                        //Navigator.pop(context);
                      }
                    },
                  ),
                ]
              ),
            ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'email', email).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_location),
                          labelText: 'Street Address',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          streetAddress = value;
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'street', streetAddress).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'City',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'city', city).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.my_location),
                          labelText: 'Full State Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          stateName = value;
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'state', stateName).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.cloud),
                          labelText: 'Country',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          country = value;
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'country', country).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          labelText: 'Zip Code',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          zipCode = int.parse(value);
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'zip', zipCode.toString()).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add),
                          labelText: 'Username',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                          ),
                          border: OutlineInputBorder(),
                        ),
                      onChanged: (value) {
                        setState(() {
                          userName = value.toString();
                        });
                     },
                    ),
                  ),
                  SizedBox(width: 16),
                  MaterialButton(
                      height: 50.0,
                      minWidth: 45.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('Update', style: TextStyle(fontSize: 30, )),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');
                          Provider.of<AuthService>(context).updateUser(_user.id, 'username', userName).then(
                            (value) {

                            }
                            
                          );
                          //Navigator.pop(context);
                        }
                      },
                    ),
                  ]
                ),
              ),
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    /*controller: _pass,
                    validator: (val){
                      if(val.isEmpty){
                        print('Empty');
                        return ('Empty');
                      }
                      return null;
                    },*/
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_searching),
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your first name!';
                      }
                      return null; 
                    },
                    onChanged: (value) {
                      setState(() {
                        user.password = value;
                      });
                    },
                  ),
                ),*/
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: _confirmPass,
                    validator: (val){
                      if(val.isEmpty){
                        print('Empty');
                        return 'Empty';
                      }
                      if(val != _pass.text){
                        print('Not Match');
                        return 'Not Match';
                      }
                      else{
                        print('Match');
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_searching),
                      labelText: 'Confirm Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.purple[500])
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                  ),
                ),*/
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                    height: 45.0,
                    minWidth: 50.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Update', style: TextStyle(fontSize: 30, )),
                    onPressed: () {
                     
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        Navigator.pop(context);
                        //Provider.of<AuthService>(context).updateUser(userName, firstName, lastName, email, 
                        //streetAddress, city, stateName, zipCode);
                        /*return FutureBuilder(
                          future: httpr.createUser(userName, firstName, lastName, email, 
                          streetAddress, city, stateName, zipCode, password),
                          builder: (context, AsyncSnapshot snapShot){
                          if(snapShot.hasData)
                          {
                            
                            return Container(color: Colors.white);
                          }
                          else
                          {
                            return Container(color: Colors.blue);
                          }
                          });*/
                      }
                    },
                      //Navigator.of(context).pushNamed('/secondsignup');
                      //createUser(userName, firstName, lastName, email, streetAddress, city, stateName, zipCode, password);
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}