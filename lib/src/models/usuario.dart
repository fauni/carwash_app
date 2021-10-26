// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.verifyEmail,
  });

  String? uid;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoUrl;
  bool? verifyEmail;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        uid: json["uid"],
        displayName: json["displayName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoUrl"],
        verifyEmail: json["verifyEmail"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoUrl": photoUrl,
        "verifyEmail": verifyEmail,
      };
}
