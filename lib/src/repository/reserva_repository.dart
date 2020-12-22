import 'dart:convert';
import 'dart:io';
import 'package:carwash/src/helpers/custom_trace.dart';
import 'package:carwash/src/models/detalle_reserva.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

/*Obtiene  reservas de acuerdo al cliente con datos de los vehiculos  */
Future<Stream<List<ReservaInner>>> obtenerReservasInnerXIdCli() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/getByIdVehiculo/' +
          idcli;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lreservaInner =
          LReservaInner.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lreservaInner.items);
    } else {
      return new Stream.value(new List<ReservaInner>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new List<ReservaInner>());
  }
}

Future<dynamic> registrarReserva(String reserva) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}reserva/save';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: reserva,
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
  return reserva;
}

Future<String> getReserva() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('reserva');
}

Future<void> setReserva(String reserva) async {
  if (reserva != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reserva', reserva);
  }
}

Future<Stream<List<DetalleReserva>>> obtenerDetalleReservaPorId(
    String idReserva) async {
  // Uri uri = Helper.getUriLfr('api/producto');
  String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}detallereserva/getdetallereserva/' +
          idReserva;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final ldetalle =
          LDetalleReserva.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(ldetalle.items);
    } else {
      return new Stream.value(new List<DetalleReserva>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    //print('error en repository al llenar '+e.toString());
    return new Stream.value(new List<DetalleReserva>());
  }
}
