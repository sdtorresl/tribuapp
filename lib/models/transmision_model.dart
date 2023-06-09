import 'dart:convert';

class TransmissionModel {
  TransmissionModel({
    required this.title,
    required this.videoCode,
    required this.chatUrl,
    required this.pollUrl,
  });

  String title;
  String videoCode;
  String chatUrl;
  String pollUrl;

  factory TransmissionModel.fromJson(String str) =>
      TransmissionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransmissionModel.fromMap(Map<String, dynamic> json) =>
      TransmissionModel(
        title: json["title"],
        videoCode: json["video-code"],
        chatUrl: json["chat-url"].toString().replaceAll("amp;", ""),
        pollUrl: json["poll-url"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "video-code": videoCode,
        "chat-url": chatUrl,
        "poll-url": pollUrl,
      };
}
