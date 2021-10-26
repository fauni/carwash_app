import 'dart:convert';

class LPublicidad {
  List<Publicidad> items = [];
  LPublicidad();
  LPublicidad.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final publicidad = new Publicidad.fromJson(item);
      items.add(publicidad);
    }
  }
}

Publicidad publicidadFromJson(String str) =>
    Publicidad.fromJson(json.decode(str));

String publicidadToJson(Publicidad data) => json.encode(data.toJson());

class Publicidad {
  Publicidad({
    this.idPublicidad,
    this.detallePublicidad,
    this.urlPublicacion,
    this.fechaPublicacion,
    this.fechaCaducidad,
    this.estado,
  });

  String? idPublicidad;
  String? detallePublicidad;
  String? urlPublicacion;
  DateTime? fechaPublicacion;
  DateTime? fechaCaducidad;
  String? estado;

  factory Publicidad.fromJson(Map<String, dynamic> json) => Publicidad(
        idPublicidad: json["idPublicidad"],
        detallePublicidad: json["detallePublicidad"],
        urlPublicacion: json["urlPublicacion"],
        fechaPublicacion: DateTime.parse(json["fechaPublicacion"]),
        fechaCaducidad: DateTime.parse(json["fechaCaducidad"]),
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idPublicidad": idPublicidad,
        "detallePublicidad": detallePublicidad,
        "urlPublicacion": urlPublicacion,
        "fechaPublicacion": fechaPublicacion!.toIso8601String(),
        "fechaCaducidad": fechaCaducidad!.toIso8601String(),
        "estado": estado,
      };
}
