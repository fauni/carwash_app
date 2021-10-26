// To parse this JSON data, do
//
//     final cdev = cdevFromJson(jsonString);

import 'dart:convert';

Cdev cdevFromJson(String str) => Cdev.fromJson(json.decode(str));

String cdevToJson(Cdev data) => json.encode(data.toJson());

class Cdev {
  Cdev({
    this.id,
    this.idCliente,
    this.idDevice,
    this.estado,
  });

  int? id;
  String? idCliente;
  String? idDevice;
  int? estado;

  factory Cdev.fromJson(Map<String, dynamic> json) => Cdev(
        id: json["id"],
        idCliente: json["idCliente"],
        idDevice: json["idDevice"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idCliente": idCliente,
        "idDevice": idDevice,
        "estado": estado,
      };
}
