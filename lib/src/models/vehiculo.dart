// To parse this JSON data, do
//
//     final vehiculo = vehiculoFromJson(jsonString);

import 'dart:convert';

class LVehiculo {
  List<Vehiculo> items = [];
  LVehiculo();
  LVehiculo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Vehiculo.fromJson(item);
      items.add(producto);
    }
  }
}

Vehiculo vehiculoFromJson(String str) => Vehiculo.fromJson(json.decode(str));

String vehiculoToJson(Vehiculo data) => json.encode(data.toJson());

class Vehiculo {
  Vehiculo(
      {this.id,
      this.placa,
      this.idModelo,
      this.idTipo,
      this.idCliente,
      this.anio,
      this.observaciones,
      this.estado,
      this.foto,
      this.imgFile});

  String? id;
  String? placa;
  String? idModelo;
  String? idTipo;
  String? idCliente;
  String? anio;
  String? observaciones;
  String? estado;
  String? foto;
  String? imgFile;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
      id: json["id"],
      placa: json["placa"],
      idModelo: json["id_modelo"],
      idTipo: json["id_tipo"],
      idCliente: json["id_cliente"],
      anio: json["anio"],
      observaciones: json["observaciones"],
      estado: json["estado"],
      foto: json["foto"],
      imgFile: json["imgFile"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "placa": placa,
        "id_modelo": idModelo,
        "id_tipo": idTipo,
        "id_cliente": idCliente,
        "anio": anio,
        "observaciones": observaciones,
        "estado": estado,
        "foto": foto,
        "imgFile": imgFile
      };
}
