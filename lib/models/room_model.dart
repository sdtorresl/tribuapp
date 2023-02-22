import 'dart:convert';

class RoomModel {
  RoomModel({
    required this.id,
    required this.title,
    required this.description,
    required this.picture,
    required this.startDate,
    required this.endDate,
    required this.fieldIcon,
    required this.isMeeting,
    required this.meetingRoom,
    required this.meetingHost,
    required this.isPrivate,
  });

  final int id;
  final String title;
  final String description;
  final String picture;
  final DateTime startDate;
  final DateTime endDate;
  final String fieldIcon;
  final bool isMeeting;
  final String meetingRoom;
  final String meetingHost;
  final bool isPrivate;

  factory RoomModel.fromJson(String str) => RoomModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomModel.fromMap(Map<String, dynamic> json) => RoomModel(
        id: int.parse(json["id"]),
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
        startDate: DateTime.parse(json["start-date"]).toLocal(),
        endDate: DateTime.parse(json["end-date"]).toLocal(),
        fieldIcon: json["field_icon"],
        isMeeting: json["video-jitsi"].toString() == "1",
        meetingHost: json["jitsi-host"],
        meetingRoom: json["jitsi-room"],
        isPrivate: json["private-room"] == "1",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "picture": picture,
        "start-date": startDate.toIso8601String(),
        "end-date": endDate.toIso8601String(),
        "field_icon": fieldIcon,
        "video-jitsi": isMeeting,
        "jitsi-host": meetingHost,
        "jitsi-room": meetingRoom,
        "private-room": isPrivate,
      };

  @override
  String toString() => toJson();
}
