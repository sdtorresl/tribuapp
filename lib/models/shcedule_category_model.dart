import 'dart:convert';

class ScheduleCategoryModel {
  ScheduleCategoryModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory ScheduleCategoryModel.fromJson(String str) =>
      ScheduleCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleCategoryModel.fromMap(Map<String, dynamic> json) =>
      ScheduleCategoryModel(
        id: int.parse(json["id"]),
        name: json["nombre"],
      );

  Map<String, dynamic> toMap() => {"id": id};

  @override
  toString() => toJson();
}
