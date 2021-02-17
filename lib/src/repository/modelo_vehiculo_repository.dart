import 'dart:convert';
import 'dart:io';

import 'package:carwash/src/helpers/custom_trace.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<List<VehiculoModelo>>> obtenerModelosVehiculo() async {
  // Uri uri = Helper.getUriLfr('api/producto');

  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}modelos/get'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculoModelo.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value(new List<VehiculoModelo>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new List<VehiculoModelo>());
  }
}

//GUARDAR MODELO DE VEHICULO
Future<dynamic> guardarModeloVehiculo(VehiculoModelo vehiculo_modelo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}modelos/save';
  final client = new http.Client();
  final response = await client.post(url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: vehiculoModeloToJson(vehiculo_modelo));
  // print(url);
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

// // Obtiene listado de vehiculo con información adicional sobre marcas, modelos y tipos
// Future<Stream<List<VehiculoA>>> obtenerVehiculosPorCliente(
//     String idCliente) async {
//   // Uri uri = Helper.getUriLfr('api/producto');

//   final String url =
//       '${GlobalConfiguration().getString('api_base_url_wash')}modelos/get/' +
//           idCliente; /*cambiar por id del cliente*/

//   final client = new http.Client();
//   final response = await client.get(url);
//   try {
//     if (response.statusCode == 200) {
//       final lvehiculo =
//           LVehiculoA.fromJsonList(json.decode(response.body)['body']);
//       return new Stream.value(lvehiculo.items);
//     } else {
//       return new Stream.value(new List<VehiculoA>());
//     }
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: url).toString());
//     //print('error en repository al llenar '+e.toString());
//     return new Stream.value(new List<VehiculoA>());
//   }
// }
