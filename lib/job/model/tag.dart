// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'dart:convert';

List<TagModel> tagModelFromJson(List str) =>
    List<TagModel>.from(str.map((x) => TagModel.fromJson(x)));

String tagModelToJson(List<TagModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagModel {
  int? id;
  String? name;
  String? slug;
  String? image;

  TagModel({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
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
