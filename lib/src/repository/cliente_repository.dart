import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:carwash/src/models/cdev.dart';
import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/usuario.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user_repository.dart' as userRepo;

/*Obtiene  clientes de acuerdo a la placa d un vehiculo dado  */
Future<Stream<List<Cliente>>> obtenerClientesXPlaca(String placa) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/getByPlaca/' +
          placa;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lcliente =
          LCliente.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lcliente.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

/*Obtiene  clientes de acuerdo a la placa d un vehiculo dado  */
Future<Stream<Cliente>> obtenerClienteXEmail(String email) async {
  final new_email = email.replaceAll('.', '|');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/getByEmail/' +
          new_email;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
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
    return new Stream.value(new Cliente());
  }
}

/*Obtiene  todos los clientes */
Future<Stream<List<Cliente>>> obtenerTodosClientes() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/get';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lcliente =
          LCliente.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lcliente.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

//guardar cliente
Future<dynamic> guardarCliente(Cliente cliente) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/save';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: clienteToJson(cliente));
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

//actualiza información del cliente
Future<dynamic> actualizarCliente(Cliente cliente) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/update';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: clienteToJson(cliente));
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

//asigna cliente elegido para crear vehiculo
Future<void> setClienteElegido(String cliente) async {
  if (cliente != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('clienteElegido', cliente);
  }
}

Future<String?> getClienteElegido() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('clienteElegido');
}

//Guarda IdDevice para notificaciones
Future<void> guardarTokenDevice(
    String token_device, String emailCliente) async {
  Cdev dev = new Cdev();
  dev.id = 0;
  dev.idCliente = emailCliente;
  dev.idDevice = token_device;
  dev.estado = 1;
  if (await verificaTokenDevice(token_device, dev)) {
    print('No se guardo!');
  } else {
    final String url =
        '${GlobalConfiguration().getString('api_base_url_wash')}clientes/savedevice';
    final client = new http.Client();
    final response = await client.post(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(dev));

    if (response.statusCode == 200) {
      print('si');
    } else {
      print('no');
    }
  }
}

Future<bool> verificaTokenDevice(String token_device, Cdev dev) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}clientes/verificaclientedevice';
  final client = new http.Client();
  final response = await client.post(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(dev));

  try {
    if (response.statusCode == 200) {
      // Map<String, dynamic> resp = jsonDecode(response.body)['body'];
      final status = jsonDecode(response.body)['status'];

      if (status == 404) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
