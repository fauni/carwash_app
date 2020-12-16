import 'dart:convert';

import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
//import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CarroController extends ControllerMVC {
  List<Vehiculo> carros = [];
  List<VehiculoA> vehiculos = [];

  String servicio = '';

  GlobalKey<ScaffoldState> scaffoldKey;

  CarroController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarCarrosByIdCli();
    listarCarrosByCliente();
    obtenerServicio();
  }

  void obtenerServicio() async {
    this.servicio = await getServicio();
  }

  void listarCarrosByIdCli({String message}) async {
    final Stream<List<Vehiculo>> stream = await obtenerVehiculos();
    stream.listen((List<Vehiculo> _productos) {
      setState(() {
        carros = _productos;
        // print("===============================");
        // //print(carros);
        // print(jsonEncode(carros));
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

  // Obtener vehiculos por codigo cliente con información adicional
  void listarCarrosByCliente({String message}) async {
    String idCliente = "1";
    final Stream<List<VehiculoA>> stream =
        await obtenerVehiculosPorCliente(idCliente);
    stream.listen((List<VehiculoA> _vehiculos) {
      setState(() {
        vehiculos = _vehiculos;
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
