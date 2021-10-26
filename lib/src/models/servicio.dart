// To parse this JSON data, do
//
//     final servicio = servicioFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

class LServicio {
  List<Servicio> items = [];
  LServicio();

  LServicio.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final servicio = new Servicio.fromJson(item);
      items.add(servicio);
    }
  }
}

Servicio servicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(Servicio data) => json.encode(data.toJson());

class Servicio {
  Servicio(
      {this.id,
      this.nombre,
      this.tipo,
      this.esAdicional,
      this.precioM,
      this.precioL,
      this.precioXl,
      this.estado,
      this.detalle,
      this.esSeleccionado});

  String? id;
  String? nombre;
  String? tipo;
  String? esAdicional;
  String? precioM;
  String? precioL;
  String? precioXl;
  String? estado;
  String? detalle;
  bool? esSeleccionado = false;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
      id: json["id"],
      nombre: json["nombre"],
      tipo: json["tipo"],
      esAdicional: json["esAdicional"],
      precioM: json["precio_m"],
      precioL: json["precio_l"],
      precioXl: json["precio_xl"],
      estado: json["estado"],
      detalle: json["detalle"],
      esSeleccionado: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
        "esAdicional": esAdicional,
        "precio_m": precioM,
        "precio_l": precioL,
        "precio_xl": precioXl,
        "estado": estado,
        "detalle": detalle,
        "esSeleccionado": false
      };
}
