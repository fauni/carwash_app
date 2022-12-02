import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/src/models/detalle_reserva.dart';
import 'package:carwash/src/models/horas.dart';
import 'package:carwash/src/models/reserva_inner.dart';
// import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
// import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/*Obtiene  reservas de acuerdo al cliente con datos de los vehiculos  */
Future<Stream<List<ReservaInner>>> obtenerReservasInnerXIdCli() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  String idcli = currentUser!.value.email!
      .replaceAll('.', '|'); /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/getByIdVehiculo/' +
          idcli;
  print(url);
  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lreservaInner =
          LReservaInner.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lreservaInner.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

// Reservas por estado cliente
Future<Stream<List<ReservaInner>>> obtenerReservasInnerXIdCliEstado(
    int estado) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  String idcli = currentUser!.value.email!
      .replaceAll('.', '|'); /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/getByIdVehiculoEstado/' +
          idcli +
          '*' +
          estado.toString();
  print(url);
  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lreservaInner =
          LReservaInner.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lreservaInner.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<dynamic> registrarReserva(String reserva) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/save';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: reserva,
  );

  print(Uri.parse(url));
  if (response.statusCode == 200) {
    //deleteServicio();
    //deleteVehiculo();
    print(response.body);
  } else {
    print(response.body);
    throw new Exception(response.body);
  }
  return reserva;
}

Future<String?> getReserva() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('reserva');
}

Future<void> setReserva(String reserva) async {
  if (reserva != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reserva', reserva);
  }
}

Future<Stream<List<DetalleReserva>>> obtenerDetalleReservaPorId(
    String idReserva) async {
  String idcli = currentUser!.value.uid!; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}detallereserva/getdetallereserva/' +
          idReserva;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final ldetalle =
          LDetalleReserva.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(ldetalle.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<ReservaInner>>> obtenerReservasPorFecha(
    String fecha_seleccionada) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/getreservasxfecha/' +
          fecha_seleccionada;

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lreservaInner =
          LReservaInner.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lreservaInner.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<Horas>>> obtenerHorarios() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/gethoras';

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lhoras = LHoras.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lhoras.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}

Future<Stream<List<Horas>>> obtenerHorariosLater(int dia) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/gethoraslaterpordia/' +
          dia.toString();

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lhoras = LHoras.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lhoras.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
