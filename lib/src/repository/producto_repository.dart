import 'dart:convert';

import 'package:carwash/src/helpers/custom_trace.dart';
import 'package:carwash/src/helpers/helper.dart';
import 'package:carwash/src/models/producto.dart';
import 'package:global_configuration/global_configuration.dart';

import 'package:http/http.dart' as http;

Future<Stream<List<Producto>>> obtenerProductos() async {
  // Uri uri = Helper.getUriLfr('api/producto');
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}producto';

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lproducto =
          LProducto.fromJsonList(json.decode(response.body)['data']);
      return new Stream.value(lproducto.items);
    } else {
      return new Stream.value(new List<Producto>());
    }
  } catch (e) {
    // print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Producto>());
  }
}
