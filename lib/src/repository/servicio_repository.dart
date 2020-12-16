import 'dart:convert';
import 'package:carwash/src/helpers/custom_trace.dart';
import 'package:carwash/src/models/servicio.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:http/http.dart' as http;

Future<Stream<List<Servicio>>> obtenerServicios() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}servicios/get';

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lservicio =
          LServicio.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lservicio.items);
    } else {
      return new Stream.value(new List<Servicio>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Servicio>());
  }
}

Future<Stream<List<Servicio>>> obtenerServiciosPorTipo(String tipo) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}servicios/getByTipo/' +
          tipo;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lservicio =
          LServicio.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lservicio.items);
    } else {
      return new Stream.value(new List<Servicio>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Servicio>());
  }
}
