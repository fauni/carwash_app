import 'dart:convert';
import 'dart:io';

import 'package:carwash/src/models/cliente.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';

/*Obtiene  clientes de acuerdo a la placa d un vehiculo dado  */
Future<Stream<List<Cliente>>> obtenerClientesXPlaca(String placa) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/getByPlaca/' +
          placa;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lcliente =
          LCliente.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lcliente.items);
    } else {
      return new Stream.value(new List<Cliente>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Cliente>());
  }
}

/*Obtiene  clientes de acuerdo a la placa d un vehiculo dado  */
Future<Stream<Cliente>> obtenerClienteXEmail(String email) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/getByEmail/' +
          email;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      final length = resp['length'];
      if (length == 0) {
        return new Stream.value(new Cliente());
      } else {
        return new Stream.value(
            Cliente.fromJson(json.decode(response.body)['body'][0]));
      }
    } else {
      return new Stream.value(new Cliente());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Cliente());
  }
}

/*Obtiene  todos los clientes */
Future<Stream<List<Cliente>>> obtenerTodosClientes() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/get';

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lcliente =
          LCliente.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lcliente.items);
    } else {
      return new Stream.value(new List<Cliente>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Cliente>());
  }
}

//guardar cliente
Future<dynamic> guardarCliente(Cliente cliente) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/save';
  final client = new http.Client();
  final response = await client.post(url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: clienteToJson(cliente));
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

//actualiza información del cliente
Future<dynamic> actualizarCliente(Cliente cliente) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/update';
  final client = new http.Client();
  final response = await client.post(url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: clienteToJson(cliente));
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

//asigna cliente elegido para crear vehiculo
Future<void> setClienteElegido(String cliente) async {
  if (cliente != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('clienteElegido', cliente);
  }
}

Future<String> getClienteElegido() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('clienteElegido');
}
