// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(Map<String, dynamic> str) =>
    UserModel.fromJson(str);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? name;
  bool? isCustomer;
  bool? isComplete;
  String? picture;
  String? phoneNumber;
  String? address;
  int? userRating;

  UserModel({
    this.email,
    this.name,
    this.isCustomer,
    this.isComplete,
    this.picture,
    this.phoneNumber,
    this.address,
    this.userRating,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        isCustomer: json["is_customer"],
        isComplete: json["is_complete"],
        picture: json["picture"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        userRating: json["user_rating"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "is_customer": isCustomer,
        "is_complete": isComplete,
        "picture": picture,
        "phone_number": phoneNumber,
        "address": address,
        "user_rating": userRating,
      };

  UserModel copyWith({
    String? email,
    String? name,
    bool? isCustomer,
    bool? isComplete,
    String? picture,
    String? phoneNumber,
    String? address,
    int? userRating,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      isCustomer: isCustomer ?? this.isCustomer,
      isComplete: isComplete ?? this.isComplete,
      picture: picture ?? this.picture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      userRating: userRating ?? this.userRating,
    );
  }
}
