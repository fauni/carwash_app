import 'dart:io';

import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/user_repository.dart' as userRepo;

class MainController extends ControllerMVC {
  List<ReservaInner> reservasInner = [];
  MainController() {
    listarReservasInnerByIdCli();
  }

//listar reservas para mostrar
  void listarReservasInnerByIdCli() async {
    final Stream<List<ReservaInner>> stream =
        await obtenerReservasInnerXIdCli();
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
      });
    }, onError: (a) {}, onDone: () {});
  }
}
