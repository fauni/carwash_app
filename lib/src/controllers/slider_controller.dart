import 'dart:convert';

import 'package:carwash/src/models/publicidad.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../src/repository/slider_repository.dart';
import '../models/slider.dart';

class SliderController extends ControllerMVC {
  List<Slider> sliders = <Slider>[];
  List<Publicidad> publicidades = <Publicidad>[];

  SliderController() {
    listenForSliders();
    cargarPublicidad();
  }

  void cargarPublicidad({String message}) async {
    final Stream<List<Publicidad>> stream = await obtenerPublicidades();
    stream.listen((List<Publicidad> _publicidades) {
      print(jsonEncode(_publicidades));
      setState(() {
        publicidades = _publicidades;
      });
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
