import 'dart:convert';
import 'dart:io';
import 'package:carwash/src/helpers/custom_trace.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

Future<Reserva> register(Reserva reserva) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}registrar';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(reserva.toMap()),
  );
  if (response.statusCode == 200) {
    //setCurrentUser(response.body);
    //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    print(response.body);
  } else {
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

