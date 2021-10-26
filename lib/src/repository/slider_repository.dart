import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/src/models/publicidad.dart';

import 'package:http/http.dart' as http;
import '../models/slider.dart';

Future<Stream<List<Publicidad>>> obtenerPublicidades() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}publicidad/get'; /*cambiar por id del cliente*/

  final client = new http.Client();
  final response = await client.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final lpublicidad =
        LPublicidad.fromJsonList(json.decode(response.body)['body']);
    return new Stream.value(lpublicidad.items);
  } else {
    return new Stream.value([]);
  }
}

Future<Stream<Slider>> getSliders() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_wash')}api/sliders'; /* Revisarrr */
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => data)
        .expand((data) => (data as List))
        .map((data) {
      return Slider.fromJSON(data);
    });
  } catch (e) {
    return new Stream.value(new Slider.fromJSON({}));
  }
}
