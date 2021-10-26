import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:carwash/src/models/tipo_vehiculo.dart';

Future<Stream<List<TipoVehiculo>>> obtenerTipoVehiculo() async {
  // Uri uri = Helper.getUriLfr('api/producto');

  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}tipovehiculo/get'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      final lvehiculo =
          LTipoVehiculo.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lvehiculo.items);
    } else {
      return new Stream.value([]);
    }
  } catch (e) {
    return new Stream.value([]);
  }
}
