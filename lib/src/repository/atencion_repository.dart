import 'dart:convert';
import 'dart:io';
// import 'package:carwash_adm/src/repository/user_repository.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:http/http.dart' as http;
import 'package:carwash/src/models/atencion.dart';
import 'package:carwash/src/models/atencion_inner.dart';
import 'package:carwash/src/models/imagenrecepcion.dart';

Future<Stream<Atencion>> getAtencionesPorReserva(String idReserva) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}atencion/getByReserva/' +
          idReserva;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final latencion =
          LAtencion.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(latencion.items[0]);
    } else {
      return new Stream.value(new Atencion());
    }
  } catch (e) {
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new Atencion());
  }
}

//obtiene atenciones relacionadas por usuario y fecha de inicio de la atención
Future<Stream<List<AtencionInner>>> getAtencionesPorUserFechaInner(
    String usuario, String fecha) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}atencion/getByUsuarioFecha/' +
          usuario +
          '/' +
          fecha;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  print(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final latencionInner =
          LAtencionInner.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(latencionInner.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

// Subir capturas de vehiculos en la recepción
Future<Stream<bool>> guardarCapturasRecepcion(
    ImagenRecepcion imagenRecepcion) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}atencion/upload';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: imagenRecepcionToJson(imagenRecepcion));
  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body)['body'];
      final status = jsonDecode(response.body)['status'];
      if (status == 201) {
        return Stream.value(true);
      } else {
        return Stream.value(false);
      }
    } else {
      return Stream.value(false);
    }
  } catch (e) {
    return Stream.value(false);
  }
}

Future<Stream<bool>> initAtencion(Atencion atencion) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}atencion/save';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: atencionToJson(atencion));
  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body)['body'];
      final status = jsonDecode(response.body)['status'];
      if (status == 201) {
        return Stream.value(true);
      } else {
        return Stream.value(false);
      }
    } else {
      return Stream.value(false);
    }
  } catch (e) {
    return Stream.value(false);
  }
}

Future<Stream<bool>> finishAtencion(Atencion atencion) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}atencion/finish';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: atencionToJson(atencion));
  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body)['body'];
      final status = jsonDecode(response.body)['status'];
      if (status == 201) {
        return Stream.value(true);
      } else {
        return Stream.value(false);
      }
    } else {
      return Stream.value(false);
    }
  } catch (e) {
    return Stream.value(false);
  }
}

Future<String> getUrlCapturas() async {
  final String url =
      '${GlobalConfiguration().getString('img_capturas_carwash')}';
  return url;
}
