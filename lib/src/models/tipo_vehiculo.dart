// To parse this JSON data, do
//
//     final tipoVehiculo = tipoVehiculoFromJson(jsonString);

import 'dart:convert';

class LTipoVehiculo {
  List<TipoVehiculo> items = [];
  LTipoVehiculo();
  LTipoVehiculo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new TipoVehiculo.fromJson(item);
      items.add(producto);
    }
  }
}

TipoVehiculo tipoVehiculoFromJson(String str) =>
    TipoVehiculo.fromJson(json.decode(str));

String tipoVehiculoToJson(TipoVehiculo data) => json.encode(data.toJson());

class TipoVehiculo {
  TipoVehiculo({
    this.id,
    this.tipo,
    this.tamanio,
  });

  String? id;
  String? tipo;
  String? tamanio;

  factory TipoVehiculo.fromJson(Map<String, dynamic> json) => TipoVehiculo(
        id: json["id"],
        tipo: json["tipo"],
        tamanio: json["tamanio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "tamanio": tamanio,
      };
}
