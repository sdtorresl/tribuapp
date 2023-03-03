import 'dart:convert';

class SocialNetworkModel {
  SocialNetworkModel({
    this.twitter,
    this.facebook,
    this.instagram,
    this.youtube,
    this.linkedin,
  });

  SocialNetworkItem? twitter;
  SocialNetworkItem? facebook;
  SocialNetworkItem? instagram;
  SocialNetworkItem? youtube;
  SocialNetworkItem? linkedin;

  factory SocialNetworkModel.fromJson(String str) =>
      SocialNetworkModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialNetworkModel.fromMap(Map<String, dynamic> json) =>
      SocialNetworkModel(
        twitter: json["twitter"] != null
            ? SocialNetworkItem.fromMap(json["twitter"])
            : null,
        facebook: json["facebook"] != null
            ? SocialNetworkItem.fromMap(json["facebook"])
            : null,
        instagram: json["instagram"] != null
            ? SocialNetworkItem.fromMap(json["instagram"])
            : null,
        youtube: json["youtube"] != null
            ? SocialNetworkItem.fromMap(json["youtube"])
            : null,
        linkedin: json["linkedin"] != null
            ? SocialNetworkItem.fromMap(json["linkedin"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "twitter": twitter?.toMap(),
        "facebook": facebook?.toMap(),
        "instagram": instagram?.toMap(),
        "youtube": youtube?.toMap(),
        "linkedin": linkedin?.toMap(),
      };

  @override
  String toString() => toJson();
}

class SocialNetworkItem {
  SocialNetworkItem({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory SocialNetworkItem.fromJson(String str) =>
      SocialNetworkItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialNetworkItem.fromMap(Map<String, dynamic> json) =>
      SocialNetworkItem(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };

  @override
  String toString() => toJson();
}
