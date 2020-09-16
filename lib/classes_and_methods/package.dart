import 'dart:core';

class Address {
  String name;
  String street1;
  String street2;
  String state;
  String city;
  String country;
  String zip;

  Address({
    this.name,
    this.street1,
    this.street2,
    this.state,
    this.city,
    this.country,
    this.zip,
  });
}

class EasyPostPackage {
  double price;
  String courier;
  Package package;
  String courierId;
  String shipmentId;
  String rateId;
  int date;

  EasyPostPackage(
      {this.price,
      this.courier,
      this.package,
      this.courierId,
      this.date,
      this.shipmentId,
      this.rateId});
}

class Package {
  int id;
  double price;
  Address sender;
  Address destination;
  double length;
  double width;
  double height;
  double weight;
  String phone;

  Package({
    this.id,
    this.price,
    this.sender,
    this.destination,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.phone,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      price: json['price'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
