// To parse this JSON data, do
//
//     final atencion = atencionFromJson(jsonString);

import 'dart:convert';

class LAtencion {
  List<Atencion> items = [];
  LAtencion();
  LAtencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final atencion = new Atencion.fromJson(item);
      items.add(atencion);
    }
  }
}

Atencion atencionFromJson(String str) => Atencion.fromJson(json.decode(str));

String atencionToJson(Atencion data) => json.encode(data.toJson());

class Atencion {
  Atencion(
      {this.id,
      this.idReserva,
      this.usuario,
      this.fechaInicio,
      this.fechaFin,
      this.precioTotal,
      this.estado,
      this.observaciones,
      this.rtsp});

  String? id;
  String? idReserva;
  String? usuario;
  String? fechaInicio;
  String? fechaFin;
  String? precioTotal;
  String? estado;
  String? observaciones;
  String? rtsp;

  factory Atencion.fromJson(Map<String, dynamic> json) => Atencion(
      id: json["id"],
      idReserva: json["idReserva"],
      usuario: json["usuario"],
      fechaInicio: json["fechaInicio"],
      fechaFin: json["fechaFin"],
      precioTotal: json["precioTotal"],
      estado: json["estado"],
      observaciones: json["observaciones"],
      rtsp: json["rtsp"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "idReserva": idReserva,
        "usuario": usuario,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "precioTotal": precioTotal,
        "estado": estado,
        "observaciones": observaciones,
        "rtsp": rtsp
      };
}
