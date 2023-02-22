import 'dart:convert';

class DocumentModel {
  DocumentModel({
    this.url,
    this.title,
    this.description,
    this.type,
  });

  String? url;
  String? title;
  String? description;
  String? type;

  factory DocumentModel.fromJson(String str) =>
      DocumentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromMap(Map<String, dynamic> json) => DocumentModel(
        url: json["url"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "title": title,
        "description": description,
        "type": type,
      };
}
