import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'user.dart';
import 'http_requests.dart' as httpr;
import 'package:frontend/forget_pass.dart';

class AuthService with ChangeNotifier {
  User currentUser;

  AuthService();

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future createUser(
      String userName,
      String firstName,
      String lastName,
      String email,
      String streetAddress,
      String city,
      String stateName,
      String zipCode,
      String password) async {
    String country = 'USA';

    Map<String, dynamic> userData = {
      'username': userName,
      'email': email,
      'sender_name': firstName + ' ' + lastName,
      'sender_street': streetAddress,
      'sender_city': city,
      'sender_state': stateName,
      'sender_country': country,
      'sender_zip': zipCode,
      'password': password
    };
    await httpr.createUserPost(userData).then((value) {
      print(value.statusCode);
      print('user created');
      print(value.body);
      if (value.statusCode == 200) {
        return Future.value(1);
      } else {
        print(value.statusCode);
        return Future.value(0);
      }
    });
  }

  // logs in the user if password matches
  Future loginUser(String username, String password) async {
    await httpr.login(username, password).then((value) {
      if (value.statusCode == 200) {
        var body = json.decode(value.body);
        User user = new User(
            id: body['id'],
            username: body['username'],
            email: body['email'],
            fullName: body['sender'],
            street: body['street'],
            city: body['city'],
            state: body['state'],
            country: body['country'],
            zip: body['zip'],
            stripeId: body['stripe_id'],
            paymentOptions: body['payment_options']);
        this.currentUser = user;
        notifyListeners();
        return Future.value(user);
      } else {
        this.currentUser = null;
        notifyListeners();
        return Future.value(null);
      }
    });
    return null;
  }

  Future updateUser(int id, String colname, String replace) async {
    await httpr.updateUser(id, colname, replace).then((value) {
      if (value.statusCode == 200) {
        switch (colname) {
          case 'sender':
            //print("sender1");
            this.currentUser.fullName = replace;
            break;
          case 'email':
            print("email1");
            this.currentUser.email = replace;
            break;
          case 'street':
            //print("street1");
            this.currentUser.street = replace;
            break;
          case 'city':
            //print("city1");
            this.currentUser.city = replace;
            break;
          case 'state':
            //print("state1");
            this.currentUser.state = replace;
            break;
          case 'country':
            //print("country1");
            this.currentUser.country = replace;
            break;
          case 'zip':
            //print("zip1");
            this.currentUser.zip = int.parse(replace);
            break;
          case 'username':
            //print("username1");
            this.currentUser.username = replace;
            break;
        }
        notifyListeners();
        print("Accepted");
        return Future.value(currentUser);
      } else {
        print(value.statusCode);
        this.currentUser = null;
        return Future.value(null);
      }
    });
  }
  Future forgetPass(String username, String email) async
  {
    bool authenticated = false;
      await httpr.forgetPass(username, email).then(
      (value) {
        //print("hello");
        print(value.body);
        print(value.statusCode);
        var body = json.decode(value.body); 
        //print(value.body);
        User user = new User(
          id: body['id'],
          username: body['username'],
          email: body['email'],
          fullName: body['sender'],
          street: body['street'],
          city: body['city'],
          state: body['state'],
          country: body['country'],
          zip: body['zip'],
          stripeId: body['stripe_id'],
          paymentOptions: body['payment_options']
        );
        
        if (value.statusCode == 200)
        {
          this.currentUser = user;
          notifyListeners();
          print("Accepted");
          sendCode(user.email, user.id);
          print(currentUser.city);
          authenticated = true;
        } 
        else 
        {
          print(value.statusCode);
          this.currentUser = null;
          //return null;
          //return Future.value(null);
        }
      }
    );
    print(authenticated);
    if(authenticated)
    {
      return Future.value(currentUser);
    }
    else
    {
      return Future.value(null);
    }
  }
  Future sendCode(String email, int userID) async
  {
    await httpr.sendEmail(email, userID).then(
    (value) {
        if (value.statusCode == 200)
        {
           notifyListeners();
           print("Works");
           return Future.value("Email Sent");
        } 
        else 
        {
           print(value.statusCode);
           return Future.value(null);
        }
      }
    );
  }
  Future verifyCode(String code, int userID) async
  {
    bool worked = false;
    await httpr.checkCode(code, userID).then(
      (value) {
        if (value.statusCode == 200)
        {
          notifyListeners();
          print("It worked!");
          worked = true;
        } 
        else 
        {
          print(value.statusCode);
          print("error");
          this.currentUser = null;
          //return Future.value(null);
        }
      }
    );
    print(worked);
    if(worked)
    {
        return Future.value("Code Confirmed");
    }
    else
    {
        return Future.value(null);
    }
  }
}
