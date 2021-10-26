// To parse this JSON data, do
//
//     final reserva = reservaFromJson(jsonString);

import 'dart:convert';

class LReserva {
  List<Reserva> items = [];
  LReserva();
  LReserva.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final reserva = new Reserva.fromJson(item);
      items.add(reserva);
    }
  }
}

Reserva reservaFromJson(String str) => Reserva.fromJson(json.decode(str));

String reservaToJson(Reserva data) => json.encode(data.toJson());

class Reserva {
  Reserva({
    this.id = "",
    this.idVehiculo = "",
    this.fechaCrea = "",
    this.fechaReserva = "",
    this.horaReserva = "",
    this.estado = "",
  });

  String id;
  String idVehiculo;
  String fechaCrea;
  String fechaReserva;
  String horaReserva;
  String estado;

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json["id"],
        idVehiculo: json["idVehiculo"],
        fechaCrea: json["fechaCrea"],
        fechaReserva: json["fechaReserva"],
        horaReserva: json["horaReserva"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idVehiculo": idVehiculo,
        "fechaCrea": fechaCrea,
        "fechaReserva": fechaReserva,
        "horaReserva": horaReserva,
        "estado": estado,
      };
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["idVehiculo"] = idVehiculo;
    map["fechaCrea"] = fechaCrea;
    map["fechaReserva"] = fechaReserva;
    map["horaReserva"] = horaReserva;
    map["estado"] = estado;
    return map;
  }
}
