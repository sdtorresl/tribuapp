import 'dart:convert';

class PrerecordedModel {
  PrerecordedModel({
    required this.title,
    required this.description,
    required this.uploadDate,
    required this.videoCode,
    required this.highlighted,
    required this.order,
    required this.category,
  });

  String title;
  String description;
  DateTime? uploadDate;
  String videoCode;
  String category;
  bool highlighted;
  int order;

  factory PrerecordedModel.fromJson(String str) =>
      PrerecordedModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrerecordedModel.fromMap(Map<String, dynamic> json) =>
      PrerecordedModel(
        title: json["title"],
        description: json["description"],
        uploadDate: DateTime.tryParse(json["upload-date"]),
        videoCode: json["video-code"],
        order: int.tryParse(json["order"]) ?? 0,
        highlighted: json["flag"] == "1",
        category: json["categoria"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "upload-date": uploadDate?.toIso8601String(),
        "video-code": videoCode,
        "highlighted": highlighted,
        "order": order,
        "category": category,
      };

  @override
  String toString() => toJson();
}
