import 'dart:convert';

class UserModel {
  UserModel({
    required this.name,
    required this.lastName,
    required this.mail,
  });

  String name;
  String lastName;
  String mail;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        lastName: json["last_name"],
        mail: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "mail": mail,
      };

  @override
  toString() => toJson();
}
