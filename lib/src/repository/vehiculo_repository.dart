import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Stream<List<Vehiculo>>> obtenerVehiculos() async {
  // Uri uri = Helper.getUriLfr('api/producto');

  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/getByIdCliente/1'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculo.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

// Obtiene listado de vehiculo con información adicional sobre marcas, modelos y tipos
Future<Stream<List<VehiculoA>>> obtenerVehiculosPorCliente(
    String idCliente) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/obtenerPorCliente/' +
          idCliente; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculoA.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

String getRutaImg(String nombre) {
  if (nombre == null) {
    return ('http://intranet.lafar.net/images/rav4.jpg'); // cambiar por otra ruta
  } else {
    if (nombre == '') {
      return ('http://intranet.lafar.net/images/rav4.jpg');
    } else {
      return '${GlobalConfiguration().getString('img_carros_url_wash')}' +
          nombre;
    }
  }
  //return('http://intranet.lafar.net/images/rav4.jpg'); // cambiar por otra ruta
}

Future<dynamic> guardarVehiculo(Vehiculo vehiculo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/save';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: vehiculoToJson(vehiculo));
  print(response);
  if (response.statusCode == 200) {
    //setCurrentUser(response.body);
    //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    // print(response.body);
  } else {
    // print(response.body);
    throw new Exception(response.body);
  }
  return response.body;
}

Future<Stream<bool>> eliminarVehiculo(String id_vehiculo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/eliminarVehiculo/' +
          id_vehiculo;
  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return new Stream.value(true);
    //setCurrentUser(response.body);
    //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else {
    return new Stream.value(false);
  }
}

Future<String> getVehiculo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('vehiculo')!;
}

Future<void> setVehiculo(String vehiculo) async {
  if (vehiculo != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vehiculo', vehiculo);
  }
}

Future<void> deleteVehiculo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('vehiculo');
}

//modificar tipo y tamaño del vehiculo
Future<dynamic> modificarVehiculo(VehiculoA vehiculo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/updtamtipo';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: vehiculoAToJson(vehiculo));
  print(Uri.parse(url));
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

//modificar foto del vehiculo
Future<dynamic> modificarFotoVehiculo(Vehiculo vehiculo) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/updfoto';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: vehiculoToJson(vehiculo));
  print(Uri.parse(url));
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
