import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes_and_methods/authenticate.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  //final TextEditingController _pass = TextEditingController();
  //final TextEditingController _confirmPass = TextEditingController();
  String userName;
  String firstName;
  String lastName;
  String email;
  String streetAddress;
  String city;
  String stateName;
  String zipCode;
  String password;
  //String confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "Sign Up Page",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ))),
      body: Center(
        child: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                //remember to add an ability to select a profile picture
                /*Icon(
                  Icons.account_circle,
                  size: 100.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                      height: 45.0,
                      minWidth: 50.0,
                      color: Colors.deepPurple[500],
                      textColor: Colors.white,
                      child: Text('Add a Profile Image',
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      onPressed: () {
                        print(email);
                        print(userName);
                        print(password);
                        //print(confirmPassword);
                        print(firstName);
                        print(lastName);
                        print(streetAddress);
                        print(city);
                        print(stateName);
                        print(zipCode);
                        //Navigator.of(context).pushNamed('/secondsignup');
                      }),
                ),*/
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  child: Divider(),
                ),*/
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'First Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
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
                        firstName = value;
                      });
                    },
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      labelText: 'Last Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your email!';
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
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.add_location),
                      labelText: 'Street Address',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your street address!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        streetAddress = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      labelText: 'City',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your city!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.my_location),
                      labelText: 'Full State Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your full state name!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        stateName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Zip Code',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your zip code!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        zipCode = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add),
                      labelText: 'Username',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your username!';
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
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                          borderSide: BorderSide(
                              width: 3.0, color: Colors.purple[500])),
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
                        password = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: MaterialButton(
                    height: 45.0,
                    minWidth: 50.0,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                        )),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        print('Submit form!');
                        Provider.of<AuthService>(context)
                            .createUser(
                                userName,
                                firstName,
                                lastName,
                                email,
                                streetAddress,
                                city,
                                stateName,
                                zipCode,
                                password)
                            .then((value) {});
                        Navigator.pop(context);
                      }
                    },
                    //Navigator.of(context).pushNamed('/secondsignup');
                    //createUser(userName, firstName, lastName, email, streetAddress, city, stateName, zipCode, password);
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
/*class SecondSignUpPage extends StatefulWidget
{
  @override
  _SecondSignUpState createState() => _SecondSignUpState();
}
class _SecondSignUpState extends State<SecondSignUpPage>
{
  @override 
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
        child: Text("Sign Up Page Continued", 
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 11.0,
            ),
          ],
        ),
      ),
    );
  }
}*/
