// To parse this JSON data, do
//
//     final horas = horasFromJson(jsonString);

import 'dart:convert';

class LHoras {
  List<Horas> items = [];
  LHoras();
  LHoras.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final horas = new Horas.fromJson(item);
      items.add(horas);
    }
  }
}

Horas horasFromJson(String str) => Horas.fromJson(json.decode(str));

String horasToJson(Horas data) => json.encode(data.toJson());

class Horas {
  Horas({this.id, this.hora, this.dia, this.esSeleccionado});

  String? id;
  String? hora;
  String? dia;
  bool? esSeleccionado = false;

  factory Horas.fromJson(Map<String, dynamic> json) => Horas(
      id: json["id"],
      hora: json["hora"],
      dia: json["dia"],
      esSeleccionado: false);

  Map<String, dynamic> toJson() =>
      {"id": id, "hora": hora, "dia": dia, "esSeleccionado": false};
}
