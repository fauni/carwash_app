// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

class LProducto {
  List<Producto> items = [];
  LProducto();
  LProducto.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Producto.fromJson(item);
      items.add(producto);
    }
  }
}

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    this.idProducto,
    this.nombreProducto,
    this.formaFarmaceutica,
    this.accionTerapeutica,
    this.nombreComercial,
    this.nombreGenerico,
    this.precio,
  });

  String? idProducto;
  String? nombreProducto;
  String? formaFarmaceutica;
  String? accionTerapeutica;
  String? nombreComercial;
  String? nombreGenerico;
  double? precio;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        formaFarmaceutica: json["formaFarmaceutica"],
        accionTerapeutica: json["accionTerapeutica"],
        nombreComercial: json["nombreComercial"],
        nombreGenerico: json["nombreGenerico"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "nombreProducto": nombreProducto,
        "formaFarmaceutica": formaFarmaceutica,
        "accionTerapeutica": accionTerapeutica,
        "nombreComercial": nombreComercial,
        "nombreGenerico": nombreGenerico,
        "precio": precio,
      };
}
