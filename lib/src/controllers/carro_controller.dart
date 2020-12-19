import 'dart:convert';

import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/tipo_vehiculo.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/repository/modelo_vehiculo_repository.dart';
import 'package:carwash/src/repository/tipo_vehiculo_repository.dart';
//import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CarroController extends ControllerMVC {
  List<Vehiculo> carros = [];
  List<VehiculoA> vehiculos = [];
  List<VehiculoModelo> modelos = [];
  List<TipoVehiculo> tipos = [];

  VehiculoA vehiculoElegido;
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

  // Obtener tipos de vehiculos
  void listarTipoVehiculo({String message}) async {
    final Stream<List<TipoVehiculo>> stream = await obtenerTipoVehiculo();
    stream.listen((List<TipoVehiculo> _data) {
      setState(() {
        tipos = _data;
        print("===============================");
        print(jsonEncode(tipos));
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

  // Obtener modelos de vehiculos
  void listarModelosVehiculo({String message}) async {
    final Stream<List<VehiculoModelo>> stream = await obtenerModelosVehiculo();
    stream.listen((List<VehiculoModelo> _modelos) {
      setState(() {
        modelos = _modelos;
        print("===============================");
        print(jsonEncode(modelos));
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

  void eligeVehiculo(VehiculoA vehiculo) async {
    this.vehiculoElegido = vehiculo;
    String strVehiculo = vehiculoAToJson(vehiculo);
    setVehiculo(strVehiculo);
    print('_________en string____________');
    print(await getVehiculo());
  }

  //registrar en servidor 
  void registrarVehiculo(Vehiculo newVehiculo){

    var vehiculoResp = guardarVehiculo(newVehiculo);
  }
}
