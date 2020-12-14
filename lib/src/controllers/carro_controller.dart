import 'dart:convert';

import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/vehiculo.dart';
//import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/producto_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CarroController extends ControllerMVC {
  
  List<Vehiculo> carros = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  CarroController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarCarrosByIdCli();
  }

  void listarCarrosByIdCli({String message}) async {
    final Stream<List<Vehiculo>> stream = await obtenerVehiculos();
    stream.listen((List<Vehiculo> _productos) {
      setState(() {
        carros = _productos;
        print("===============================");
        //print(carros);
         print(jsonEncode(carros));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
}
