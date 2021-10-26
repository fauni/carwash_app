// To parse this JSON data, do
//
//     final vehiculoA = vehiculoAFromJson(jsonString);

import 'dart:convert';

class LVehiculoA {
  List<VehiculoA> items = [];
  LVehiculoA();
  LVehiculoA.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new VehiculoA.fromJson(item);
      items.add(producto);
    }
  }
}

VehiculoA vehiculoAFromJson(String str) => VehiculoA.fromJson(json.decode(str));

String vehiculoAToJson(VehiculoA data) => json.encode(data.toJson());

class VehiculoA {
  VehiculoA(
      {this.id,
      this.placa,
      this.idModelo,
      this.modelo,
      this.marca,
      this.idTipo,
      this.tipo,
      this.tamanio,
      this.anio,
      this.observaciones,
      this.estado,
      this.foto,
      this.esElegido});

  String? id;
  String? placa;
  String? idModelo;
  String? modelo;
  String? marca;
  String? idTipo;
  String? tipo;
  String? tamanio;
  String? anio;
  String? observaciones;
  String? estado;
  String? foto;
  bool? esElegido = false;

  factory VehiculoA.fromJson(Map<String, dynamic> json) => VehiculoA(
      id: json["id"],
      placa: json["placa"],
      idModelo: json["id_modelo"],
      modelo: json["modelo"],
      marca: json["marca"],
      idTipo: json["id_tipo"],
      tipo: json["tipo"],
      tamanio: json["tamanio"],
      anio: json["anio"],
      observaciones: json["observaciones"],
      estado: json["estado"],
      foto: json["foto"],
      esElegido: json["es_elegido"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "placa": placa,
        "id_modelo": idModelo,
        "modelo": modelo,
        "marca": marca,
        "id_tipo": idTipo,
        "tipo": tipo,
        "tamanio": tamanio,
        "anio": anio,
        "observaciones": observaciones,
        "estado": estado,
        "foto": foto,
        "es_elegido": esElegido
      };
}
