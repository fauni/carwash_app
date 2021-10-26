// To parse this JSON data, do
//
//     final detalleReserva = detalleReservaFromJson(jsonString);

import 'dart:convert';

class LDetalleReserva {
  List<DetalleReserva> items = [];
  LDetalleReserva();
  LDetalleReserva.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final reserva = new DetalleReserva.fromJson(item);
      items.add(reserva);
    }
  }
}

DetalleReserva detalleReservaFromJson(String str) =>
    DetalleReserva.fromJson(json.decode(str));

String detalleReservaToJson(DetalleReserva data) => json.encode(data.toJson());

class DetalleReserva {
  DetalleReserva(
      {this.id,
      this.idReserva,
      this.idServicio,
      this.estado,
      this.nombre,
      this.precioM,
      this.precioL,
      this.precioXl,
      this.detalle,
      this.precio});

  String? id;
  String? idReserva;
  String? idServicio;
  String? estado;
  String? nombre;
  String? precioM;
  String? precioL;
  String? precioXl;
  String? detalle;
  String? precio;

  factory DetalleReserva.fromJson(Map<String, dynamic> json) => DetalleReserva(
      id: json["id"],
      idReserva: json["idReserva"],
      idServicio: json["idServicio"],
      estado: json["estado"],
      nombre: json["nombre"],
      precioM: json["precio_m"],
      precioL: json["precio_l"],
      precioXl: json["precio_xl"],
      detalle: json["detalle"],
      precio: json["precio"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "idReserva": idReserva,
        "idServicio": idServicio,
        "estado": estado,
        "nombre": nombre,
        "precio_m": precioM,
        "precio_l": precioL,
        "precio_xl": precioXl,
        "detalle": detalle,
        "precio": precio
      };
}
