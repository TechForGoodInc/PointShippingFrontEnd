class User {
  int id;
  String username;
  String email; 
  String fullName;
  String street;
  String city; 
  String state; 
  String country;
  int zip; 
  String stripeId; 
  var paymentOptions; 

  User({this.id, this.username, this.email, this.fullName, this.street, this.city, this.state, this.country, this.zip, this.stripeId, this.paymentOptions});

}
