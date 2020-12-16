// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:global_configuration/global_configuration.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:html/parser.dart';

class Helper {
  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Uri getUri(String path) {
    String _path = Uri.parse(GlobalConfiguration().getString('base_url')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().getString('base_url')).scheme,
        host: Uri.parse(GlobalConfiguration().getString('base_url')).host,
        port: Uri.parse(GlobalConfiguration().getString('base_url')).port,
        path: _path + path);
    return uri;
  }

  static Uri getUriLfr(String path) {
    String _path =
        Uri.parse(GlobalConfiguration().getString('base_url_lfr')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme:
            Uri.parse(GlobalConfiguration().getString('base_url_lfr')).scheme,
        host: Uri.parse(GlobalConfiguration().getString('base_url_lfr')).host,
        port: Uri.parse(GlobalConfiguration().getString('base_url_lfr')).port,
        path: _path + path);
    return uri;
  }

  // Uri para API de CARWASH
  static Uri getUriWash(String path) {
    String _path =
        Uri.parse(GlobalConfiguration().getString('api_base_url_wash')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().getString('api_base_url_wash'))
            .scheme,
        host: Uri.parse(GlobalConfiguration().getString('api_base_url_wash'))
            .host,
        port: Uri.parse(GlobalConfiguration().getString('api_base_url_wash'))
            .port,
        path: _path + path);
    return uri;
  }
}
