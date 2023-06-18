// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

List<JobModel> jobModelFromJson(dynamic str) =>
    List<JobModel>.from(str.map((x) => JobModel.fromJson(x)));

String jobModelToJson(List<JobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  int? id;
  String? slug;
  String? description;
  int? timeMinutes;
  List<Tag>? tags;
  String? image;
  int? user;
  String? location;
  int? customerRating;
  String? status;
  Bid? acceptedBid;
  DateTime? createdAt;
  List<Bid>? bids;
  bool? isOpen;
  DateTime? date;

  JobModel({
    this.id,
    this.slug,
    this.description,
    this.timeMinutes,
    this.tags,
    this.image,
    this.user,
    this.location,
    this.customerRating,
    this.status,
    this.acceptedBid,
    this.createdAt,
    this.bids,
    this.isOpen,
    this.date,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        slug: json["slug"],
        description: json["description"],
        timeMinutes: json["time_minutes"],
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        image: json["image"],
        user: json["user"],
        location: json["location"],
        customerRating: json["customer_rating"],
        status: json["status"],
        acceptedBid: json["accepted_bid"] == null
            ? null
            : Bid.fromJson(json["accepted_bid"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        bids: json["bids"] == null
            ? []
            : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
        isOpen: json["is_open"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "description": description,
        "time_minutes": timeMinutes,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "image": image,
        "user": user,
        "location": location,
        "customer_rating": customerRating,
        "status": status,
        "accepted_bid": acceptedBid?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "bids": bids == null
            ? []
            : List<dynamic>.from(bids!.map((x) => x.toJson())),
        "is_open": isOpen,
        "date": date?.toIso8601String(),
      };
}

class Bid {
  int? id;
  String? slug;
  User? user;
  int? job;
  int? amount;

  Bid({
    this.id,
    this.slug,
    this.user,
    this.job,
    this.amount,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        id: json["id"],
        slug: json["slug"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        job: json["job"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "user": user?.toJson(),
        "job": job,
        "amount": amount,
      };
}

class User {
  String? name;
  String? picture;
  String? phoneNumber;
  String? address;
  int? id;
  String? email;
  int? userRating;

  User({
    this.name,
    this.picture,
    this.phoneNumber,
    this.address,
    this.id,
    this.email,
    this.userRating,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        picture: json["picture"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        id: json["id"],
        email: json["email"],
        userRating: json["user_rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
        "phone_number": phoneNumber,
        "address": address,
        "id": id,
        "email": email,
        "user_rating": userRating,
      };
}

class Tag {
  int? id;
  String? name;
  String? slug;
  String? image;

  Tag({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
      };
}
