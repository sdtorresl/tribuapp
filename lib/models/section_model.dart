import 'dart:convert';

class SectionModel {
  SectionModel({
    this.title,
    this.description,
    this.picture,
  });

  String? title;
  String? description;
  final picture;

  factory SectionModel.fromJson(String str) =>
      SectionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "picture": picture,
      };

  @override
  toString() => toJson();
}
