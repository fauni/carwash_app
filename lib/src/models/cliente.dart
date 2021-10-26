// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

class LCliente {
  List<Cliente> items = [];
  LCliente();
  LCliente.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final cliente = new Cliente.fromJson(item);
      items.add(cliente);
    }
  }
}

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    this.id,
    this.codigoCliente,
    this.nombreCompleto,
    this.email,
    this.telefono,
    this.estado,
  });

  String? id;
  String? codigoCliente;
  String? nombreCompleto;
  String? email;
  String? telefono;
  String? estado;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        codigoCliente: json["codigoCliente"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        telefono: json["telefono"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigoCliente": codigoCliente,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "telefono": telefono,
        "estado": estado,
      };
}
