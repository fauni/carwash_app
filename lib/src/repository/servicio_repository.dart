import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/src/models/servicio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

Future<Stream<List<Servicio>>> obtenerServicios() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}servicios/get';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lservicio =
          LServicio.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lservicio.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<Servicio>>> obtenerServiciosPorTipo(String tipo) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}servicios/getByTipo/' +
          tipo;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lservicio =
          LServicio.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lservicio.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<Servicio>>> obtenerServiciosPorTipoPro(String tipo) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}servicios/getByTipoPro/' +
          tipo;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lservicio =
          LServicio.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lservicio.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<String?> getServicio() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('servicio');
}

Future<void> setServicio(String servicio) async {
  if (servicio != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('servicio', servicio);
  }
}

Future<void> deleteServicio() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('servicio');
}
