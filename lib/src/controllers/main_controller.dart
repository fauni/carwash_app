import 'dart:io';

import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/nativo/compartir_facebook.dart';
import 'package:carwash/src/pages/shared_page.dart';
import 'package:carwash/src/repository/cliente_repository.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:carwash/src/repository/user_repository.dart';

class MainController extends ControllerMVC {
  String? token;
  List<ReservaInner> reservasInner = [];

  CompartirFacebook platform = new CompartirFacebook();

  MainController() {
    listarReservasInnerByIdCli();
    // obtenerTokenDevice();
  }

//listar reservas para mostrar
  void listarReservasInnerByIdCli() async {
    final Stream<List<ReservaInner>> stream =
        await obtenerReservasInnerXIdCli();
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
        obtenerTokenDevice();
      });
    }, onError: (a) {}, onDone: () {});
  }

  void obtenerTokenDevice() async {
    token = await getToken();
    String email = currentUser!.value.email!;
    guardarTokenDevice(token!, email);
  }

  Future<void> abrirCompartir(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharedPage(),
      ),
    );
    if (resultado) {
    } else {}
  }
}
