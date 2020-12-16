import 'dart:convert';
import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FechaController extends ControllerMVC {
  List<Servicio> servicios = [];

  int selectedFoodVariants = 0;
  int selectedPortionCounts = 0;
  int selectedPortionSize = 0;

  GlobalKey<ScaffoldState> scaffoldKey;

  FechaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // listarServicios();
  }

  void listarServicios({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServicios();
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        servicios = _servicios;
        print("===============================");
        print(jsonEncode(servicios));
        // print(json.encode(favoritos));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void seleccionarHora(DateTime hora) {
    String time = hora.toString();
    setServicio(time);
  }
}
