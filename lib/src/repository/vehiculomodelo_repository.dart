import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:carwash/src/models/vehiculo_modelo.dart';

Future<Stream<List<VehiculoModelo>>> obtenerModelosVehiculo() async {
  // Uri uri = Helper.getUriLfr('api/producto');

  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}modelos/get'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculoModelo.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

//GUARDAR MODELO DE VEHICULO
Future<dynamic> guardarModeloVehiculo(VehiculoModelo vehiculo_modelo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}modelos/save';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: vehiculoModeloToJson(vehiculo_modelo));
  // print(Uri.parse(url));
  if (response.statusCode == 200) {
    //setCurrentUser(response.body);
    //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(response.body);
  } else {
    print(response.body);
    throw new Exception(response.body);
  }
  return response.body;
}
