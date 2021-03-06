import 'dart:convert';
import 'dart:io';

import 'package:carwash/src/helpers/custom_trace.dart';
//import 'package:carwash/src/helpers/helper.dart';
//import 'package:carwash/src/models/producto.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Stream<List<Vehiculo>>> obtenerVehiculos() async {
  // Uri uri = Helper.getUriLfr('api/producto');

  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/getByIdCliente/1'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculo.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value(new List<Vehiculo>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new List<Vehiculo>());
  }
}

// Obtiene listado de vehiculo con información adicional sobre marcas, modelos y tipos
Future<Stream<List<VehiculoA>>> obtenerVehiculosPorCliente(
    String idCliente) async {
  // Uri uri = Helper.getUriLfr('api/producto');

  //final cliente = idCliente.replaceAll('.', '|');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}vehiculos/obtenerPorCliente/' +
          idCliente; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LVehiculoA.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value(new List<VehiculoA>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new List<VehiculoA>());
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
  final response = await client.post(url,
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
  final response = await client.get(url);
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
  return await prefs.get('vehiculo');
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
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: vehiculoAToJson(vehiculo) 
  );
   print(url);
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
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: vehiculoToJson(vehiculo) 
  );
   print(url);
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