import 'dart:convert';

class LReservaInner {
  List<ReservaInner> items = [];
  LReservaInner();
  LReservaInner.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final reserva = new ReservaInner.fromJson(item);
      items.add(reserva);
    }
  }
}

ReservaInner reservaInnerFromJson(String str) =>
    ReservaInner.fromJson(json.decode(str));

String reservaInnerToJson(ReservaInner data) => json.encode(data.toJson());

class ReservaInner {
  ReservaInner(
      {this.id,
      this.idVehiculo,
      this.fechaCrea,
      this.fechaReserva,
      this.horaReserva,
      this.estado,
      this.placa,
      this.idCliente,
      this.tipo,
      this.tamanio,
      this.modelo,
      this.marca,
      this.foto});

  String? id;
  String? idVehiculo;
  String? fechaCrea;
  String? fechaReserva;
  String? horaReserva;
  String? estado;
  String? placa;
  String? idCliente;
  String? tipo;
  String? tamanio;
  String? modelo;
  String? marca;
  String? foto;

  factory ReservaInner.fromJson(Map<String, dynamic> json) => ReservaInner(
      id: json["id"],
      idVehiculo: json["idVehiculo"],
      fechaCrea: json["fechaCrea"],
      fechaReserva: json["fechaReserva"],
      horaReserva: json["horaReserva"],
      estado: json["estado"],
      placa: json["placa"],
      idCliente: json["id_cliente"],
      tipo: json["tipo"],
      tamanio: json["tamanio"],
      modelo: json["modelo"],
      marca: json["marca"],
      foto: json["foto"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "idVehiculo": idVehiculo,
        "fechaCrea": fechaCrea,
        "fechaReserva": fechaReserva,
        "horaReserva": horaReserva,
        "estado": estado,
        "placa": placa,
        "id_cliente": idCliente,
        "tipo": tipo,
        "tamanio": tamanio,
        "modelo": modelo,
        "marca": marca,
        "foto": foto
      };
}
