import 'dart:convert';
import 'package:carwash/src/models/horas.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FechaController extends ControllerMVC {
  List<Servicio> servicios = [];
  List<ReservaInner> reservasInner = [];
  List<Horas> horas = [];

  int selectedFoodVariants = 0;
  int selectedPortionCounts = 0;
  int selectedPortionSize = 0;

  GlobalKey<ScaffoldState> scaffoldKey;

  FechaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // listarServicios();
    listarReservasDeHoy();
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

  Future<void> listarReservasDeHoy({String message}) async {
    // FocusScope.of(context).unfocus();
    // Overlay.of(context).insert(loader);

    final Stream<List<ReservaInner>> stream =
        await obtenerReservasInnerCurrent();
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
        listarHorarioHoy();
      });
    }, onError: (a) {
      // loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener reservas'),
      ));
    }, onDone: () {
      // Helper.hideLoader(loader);
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> listarHorarioHoy() async {
    // FocusScope.of(context).unfocus();
    // Overlay.of(context).insert(loader);

    final Stream<List<Horas>> stream = await obtenerHorarios();
    stream.listen((List<Horas> _horas) {
      setState(() {
        horas = _horas;
        print(jsonEncode(horas));
      });
    }, onError: (a) {
      // loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener las horas'),
      ));
    }, onDone: () {
      // Helper.hideLoader(loader);
    });
  }
}
