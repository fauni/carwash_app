import 'dart:convert';

import 'package:carwash/src/models/publicidad.dart';

import '../../src/helpers/custom_trace.dart';
import 'package:http/http.dart' as http;
import '../../src/helpers/helper.dart';
import '../models/slider.dart';

Future<Stream<List<Publicidad>>> obtenerPublicidades() async {
  Uri url = Helper.getUriWash('publicidad/get');

  final client = new http.Client();
  final response = await client.get(url);

  if (response.statusCode == 200) {
    final lpublicidad =
        LPublicidad.fromJsonList(json.decode(response.body)['body']);
    return new Stream.value(lpublicidad.items);
  } else {
    return new Stream.value(new List<Publicidad>());
  }
}

Future<Stream<Slider>> getSliders() async {
  Uri uri = Helper.getUri('api/sliders');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Slider.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Slider.fromJSON({}));
  }
}
