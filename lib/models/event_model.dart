// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'dart:convert';

import 'package:bmwapp/models/section_model.dart';

import 'document_model.dart';

class EventModel {
  EventModel({
    this.title,
    this.description,
    this.picture,
    this.startDate,
    this.endDate,
    this.sections,
    this.documents,
  });

  String? title;
  String? description;
  String? picture;
  DateTime? startDate;
  DateTime? endDate;
  List<SectionModel>? sections;
  List<DocumentModel>? documents;

  factory EventModel.fromJson(String str) =>
      EventModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
        startDate: DateTime.parse(json["start-date"]).toLocal(),
        endDate: DateTime.parse(json["end-date"]).toLocal(),
        sections: List<SectionModel>.from(
            json["sections"].map((x) => SectionModel.fromMap(x))),
        documents: List<DocumentModel>.from(
            json["documents"].map((x) => DocumentModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "picture": picture,
        "start-date": startDate?.toIso8601String(),
        "end-date": endDate?.toIso8601String(),
        //  "sections": List<dynamic>.from(sections.map((x) => x.toMap())),
        // "documents": List<dynamic>.from(documents.map((x) => x.toMap())),
        "sections": List<dynamic>.from(sections!.map((x) => x.toMap())),
        "documents": List<dynamic>.from(documents!.map((x) => x.toMap())),
      };

  @override
  // before: String toString() => this.toJson();
  String toString() => toJson();
}
