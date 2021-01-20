import 'dart:convert';

import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ServicioController extends ControllerMVC {
  VehiculoA vehiculoElegido = new VehiculoA();
  List<Servicio> servicios = [];

  List<Servicio> serviciosElegidos = [];

  List<Servicio> serviciosGeneral = [];
  List<Servicio> serviciosAdicionales = [];
  List<Servicio> serviciosMotos = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  double subTotal = 0.0;
  double total = 0.0;

  ServicioController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    obtenerVehiculo();
    listarServicios();
    listarServiciosAdicionales();
    listarServiciosMotos();
  }

  void obtenerVehiculo() async {
    String vehiculo_json = await getVehiculo();
    if (vehiculo_json == null) {
      Navigator.pop(context);
      Navigator.of(context).push(
        new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new CarroPage(switchValue: null, valueChanged: null);
            },
            fullscreenDialog: true),
      );
    } else {
      vehiculoElegido = VehiculoA.fromJson(jsonDecode(vehiculo_json));
    }
    // print(jsonEncode(vehiculoElegido));
  }

  void listarServicios({String message}) async {
    // final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('1');
    final Stream<List<Servicio>> stream = await obtenerServicios();
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        servicios = _servicios;
        serviciosGeneral = _servicios;
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

  void listarServiciosMotos({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('2');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosMotos = _servicios;
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

  void listarServiciosAdicionales({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('3');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosAdicionales = _servicios;
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

  void insertaServElegidos(Servicio serv) async {
    bool seElimino = eliminaServElegido(serv);

    if (seElimino == false) {
      this.serviciosElegidos.add(serv);
    }

    List<dynamic> lservJson = new List<dynamic>();
    for (var itms in this.serviciosElegidos) {
      lservJson.add(itms.toJson());
    }

    String servString = json.encode(lservJson);
    setServicio(servString);
    print('_____en share preferences:______');
    print(await getServicio());
    calculateSubtotal();
  }

  bool eliminaServElegido(Servicio serv) {
    List<Servicio> srvTemp = [];
    bool resp = false;
    for (var srv in serviciosElegidos) {
      if (serv.id.compareTo(srv.id) != 0) {
        srvTemp.add(srv);
      } else {
        resp = true;
      }
    }
    if (resp) {
      serviciosElegidos = srvTemp;
      calculateSubtotal();
    }
    return resp;
  }

  void calculateSubtotal() async {
    subTotal = 0;
    total = 0;

    serviciosElegidos.forEach(
      (serv) {
        if (vehiculoElegido.tamanio == 'M') {
          subTotal = subTotal + double.parse(serv.precioM);
        } else if (vehiculoElegido.tamanio == 'L') {
          subTotal = subTotal + double.parse(serv.precioL);
        } else {
          subTotal = subTotal + double.parse(serv.precioXl);
        }
      },
    );
    total = subTotal;
    setState(() {});
  }
}
