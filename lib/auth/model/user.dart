// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(Map<String, dynamic> str) => UserModel.fromJson(str);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? name;
  bool? isCustomer;
  bool? isComplete;
  String? picture;
  String? phoneNumber;
  String? address;

  UserModel({
    this.email,
    this.name,
    this.isCustomer,
    this.isComplete,
    this.picture,
    this.phoneNumber,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        isCustomer: json["is_customer"],
        isComplete: json["is_complete"],
        picture: json["picture"],
        phoneNumber: json["phone_number"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "is_customer": isCustomer,
        "is_complete": isComplete,
        "picture": picture,
        "phone_number": phoneNumber,
        "address": address,
      };
}
