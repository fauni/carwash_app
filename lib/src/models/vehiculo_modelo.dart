// To parse this JSON data, do
//
//     final vehiculoModelo = vehiculoModeloFromJson(jsonString);

import 'dart:convert';

class LVehiculoModelo {
  List<VehiculoModelo> items = [];
  LVehiculoModelo();
  LVehiculoModelo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new VehiculoModelo.fromJson(item);
      items.add(producto);
    }
  }
}

VehiculoModelo vehiculoModeloFromJson(String str) =>
    VehiculoModelo.fromJson(json.decode(str));

String vehiculoModeloToJson(VehiculoModelo data) => json.encode(data.toJson());

class VehiculoModelo {
  VehiculoModelo({
    this.id,
    this.anio,
    this.marca,
    this.modelo,
  });

  String? id;
  String? anio;
  String? marca;
  String? modelo;

  factory VehiculoModelo.fromJson(Map<String, dynamic> json) => VehiculoModelo(
        id: json["id"],
        anio: json["anio"],
        marca: json["marca"],
        modelo: json["modelo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "anio": anio,
        "marca": marca,
        "modelo": modelo,
      };
}
