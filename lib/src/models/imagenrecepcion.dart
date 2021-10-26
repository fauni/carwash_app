// To parse this JSON data, do
//
//     final imagenRecepcion = imagenRecepcionFromJson(jsonString);

import 'dart:convert';

class LImagenRecepcion {
  List<ImagenRecepcion> items = [];
  LImagenRecepcion();
  LImagenRecepcion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final img = new ImagenRecepcion.fromJson(item);
      items.add(img);
    }
  }
}

ImagenRecepcion imagenRecepcionFromJson(String str) =>
    ImagenRecepcion.fromJson(json.decode(str));

String imagenRecepcionToJson(ImagenRecepcion data) =>
    json.encode(data.toJson());

class ImagenRecepcion {
  ImagenRecepcion({
    this.id,
    this.idReserva,
    this.imgLeft,
    this.imgRigth,
    this.imgFront,
    this.imgBack,
  });

  String? id;
  String? idReserva;
  String? imgLeft;
  String? imgRigth;
  String? imgFront;
  String? imgBack;

  factory ImagenRecepcion.fromJson(Map<String, dynamic> json) =>
      ImagenRecepcion(
        id: json["id"],
        idReserva: json["idReserva"],
        imgLeft: json["imgLeft"],
        imgRigth: json["imgRigth"],
        imgFront: json["imgFront"],
        imgBack: json["imgBack"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idReserva": idReserva,
        "imgLeft": imgLeft,
        "imgRigth": imgRigth,
        "imgFront": imgFront,
        "imgBack": imgBack,
      };
}
