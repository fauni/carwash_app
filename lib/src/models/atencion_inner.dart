// To parse this JSON data, do
//
//     final atencionInner = atencionInnerFromJson(jsonString);

import 'dart:convert';

class LAtencionInner {
  List<AtencionInner> items = [];
  LAtencionInner();
  LAtencionInner.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final atencion = new AtencionInner.fromJson(item);
      items.add(atencion);
    }
  }
}

AtencionInner atencionInnerFromJson(String str) =>
    AtencionInner.fromJson(json.decode(str));

String atencionInnerToJson(AtencionInner data) => json.encode(data.toJson());

class AtencionInner {
  AtencionInner({
    this.id,
    this.idReserva,
    this.usuario,
    this.fechaInicio,
    this.fechaFin,
    this.precioTotal,
    this.estado,
    this.observaciones,
    this.placa,
    this.idCliente,
    this.nombreCompleto,
    this.idModelo,
    this.model,
  });

  String? id;
  String? idReserva;
  String? usuario;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  String? precioTotal;
  String? estado;
  String? observaciones;
  String? placa;
  String? idCliente;
  String? nombreCompleto;
  String? idModelo;
  String? model;

  factory AtencionInner.fromJson(Map<String, dynamic> json) => AtencionInner(
        id: json["id"],
        idReserva: json["idReserva"],
        usuario: json["usuario"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        precioTotal: json["precioTotal"],
        estado: json["estado"],
        observaciones: json["observaciones"],
        placa: json["placa"],
        idCliente: json["id_cliente"],
        nombreCompleto: json["nombreCompleto"],
        idModelo: json["id_modelo"],
        model: json["model"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idReserva": idReserva,
        "usuario": usuario,
        "fechaInicio": fechaInicio!.toIso8601String(),
        "fechaFin": fechaFin!.toIso8601String(),
        "precioTotal": precioTotal,
        "estado": estado,
        "observaciones": observaciones,
        "placa": placa,
        "id_cliente": idCliente,
        "nombreCompleto": nombreCompleto,
        "id_modelo": idModelo,
        "model": model,
      };
}
