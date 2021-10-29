import 'dart:convert';

import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/pages/carro_page.dart';
// import 'package:carwash/src/pages/carro_page.dart';
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

/* SERVICIOS PRO */
  List<Servicio> serviciospro = [];
  List<Servicio> serviciosGeneralPro = [];
  List<Servicio> serviciosLavadosExtrasPro = [];
  List<Servicio> serviciosExtrasPro = [];
/* END SERVICIOS PRO*/

  GlobalKey<ScaffoldState>? scaffoldKey;
  BuildContext? _contexto;

  double? subTotal = 0.0;
  double? total = 0.0;

  bool isRadioSelected = false;
  int currentServicioValue = 1;
  int? valueRadio;

  ServicioController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // obtenerVehiculo(this._contexto!); // Revisar
    listarServicios();
    listarServiciosAdicionales();
    // listarServiciosMotos();
    listarServiciosPro();
    listarLavadosExtras();
    listarServiciosExtrasPro();
  }

  Future<void> obtenerVehiculo(BuildContext context) async {
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

  void listarServicios() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('0');
    // final Stream<List<Servicio>> stream = await obtenerServicios();
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        servicios = _servicios;
        serviciosGeneral = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void listarServiciosPro() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipoPro('0');
    // final Stream<List<Servicio>> stream = await obtenerServicios();
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciospro = _servicios;
        serviciosGeneralPro = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void listarLavadosExtras() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipoPro('1');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosLavadosExtrasPro = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void listarServiciosExtrasPro() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipoPro('2');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosExtrasPro = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void listarServiciosMotos() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('2');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosMotos = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void listarServiciosAdicionales() async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('1');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosAdicionales = _servicios;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {});
  }

  void insertaServElegidosAdicional(Servicio serv) async {
    bool seElimino = eliminaServElegido(serv);

    if (seElimino == false) {
      this.serviciosElegidos.add(serv);
    }

    List<dynamic> lservJson = [];
    for (var itms in this.serviciosElegidos) {
      lservJson.add(itms.toJson());
    }

    String servString = json.encode(lservJson);
    setServicio(servString);
    print('_____en share preferences:______');
    print(await getServicio());
    calculateSubtotal();
  }

  void insertaServElegidosGeneral(Servicio serv) async {
    eliminaServElegidoGenerales();
    this.serviciosElegidos.add(serv);
    List<dynamic> lservJson = [];
    for (var itms in this.serviciosElegidos) {
      lservJson.add(itms.toJson());
    }

    String servString = json.encode(lservJson);
    setServicio(servString);
    print('_____en share preferences:______');
    print(await getServicio());
    calculateSubtotal();
  }

  void eliminaServElegidoGenerales() {
    List<Servicio> srvTemp = [];
    for (var srv in serviciosElegidos) {
      if (srv.esAdicional == "1") {
        srvTemp.add(srv);
      }
    }
    serviciosElegidos = srvTemp;
    calculateSubtotal();
  }

  bool eliminaServElegido(Servicio serv) {
    List<Servicio> srvTemp = [];
    bool resp = false;
    for (var srv in serviciosElegidos) {
      if (serv.id!.compareTo(srv.id!) != 0) {
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
          subTotal = subTotal! + double.parse(serv.precioM!);
        } else if (vehiculoElegido.tamanio == 'L') {
          subTotal = subTotal! + double.parse(serv.precioL!);
        } else {
          subTotal = subTotal! + double.parse(serv.precioXl!);
        }
      },
    );
    total = subTotal;
    setState(() {});
  }
}
