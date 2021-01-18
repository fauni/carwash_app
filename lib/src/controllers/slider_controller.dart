import 'dart:convert';

import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/publicidad.dart';
import 'package:carwash/src/repository/cliente_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../src/repository/slider_repository.dart';
import '../models/slider.dart';

class SliderController extends ControllerMVC {
  List<Slider> sliders = <Slider>[];
  List<Publicidad> publicidades = <Publicidad>[];

  SliderController() {
    // listenForSliders();
    cargarPublicidad();
  }

  void cargarPublicidad({String message}) async {
    final Stream<List<Publicidad>> stream = await obtenerPublicidades();
    stream.listen((List<Publicidad> _publicidades) {
      validaRegistroCliente();
      setState(() {
        publicidades = _publicidades;
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> validaRegistroCliente() async {
    final Stream<Cliente> stream =
        await obtenerClienteXEmail(currentUser.value.email);
    stream.listen((Cliente _cliente) {
      setState(() {
        if (_cliente.codigoCliente == null) {
          Navigator.of(context).pushNamed('/Cliente', arguments: new Cliente());
        } else {
          if (_cliente.codigoCliente == '0') {
            Navigator.of(context).pushNamed('/Cliente', arguments: _cliente);
          }
        }
      });
      // print(json.encode(_producto));
      // setState(() => productoSemana.add(_producto));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForSliders({String message}) async {
    final Stream<Slider> stream = await getSliders();
    stream.listen((Slider _slider) {
      setState(() {
        sliders.add(_slider);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshSliders() async {
    sliders.clear();
    publicidades.clear();
    cargarPublicidad(message: 'Se actualizo las publicidades correctamente!');
    listenForSliders(message: 'Sliders refreshed successfuly');
  }
}
