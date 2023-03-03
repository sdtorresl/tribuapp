import 'dart:convert';

class SectionModel {
  SectionModel({
    required this.title,
    required this.description,
    required this.picture,
  });

  final String title;
  final String description;
  final String picture;

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
