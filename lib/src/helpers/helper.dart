import 'dart:async';

import 'package:carwash/src/widgets/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class Helper {
  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int);
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool);
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static String getUrlImagenes(String path) {
    String url =
        GlobalConfiguration().getValue('base_url_imagenes_usuarios') + path;

    return url;
  }

  static String getUrlImagenesEmpleados(String path) {
    String url =
        GlobalConfiguration().getValue('base_url_imagenes_empleados') + path;

    return url;
  }

  static Uri getUri(String path) {
    String _path = Uri.parse(GlobalConfiguration().getValue('base_url')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().getValue('base_url')).scheme,
        host: Uri.parse(GlobalConfiguration().getValue('base_url')).host,
        port: Uri.parse(GlobalConfiguration().getValue('base_url')).port,
        path: _path + path);
    return uri;
  }

  static Uri getUriLfr(String path) {
    String _path =
        Uri.parse(GlobalConfiguration().getValue('base_url_lfr')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme:
            Uri.parse(GlobalConfiguration().getValue('base_url_lfr')).scheme,
        host: Uri.parse(GlobalConfiguration().getValue('base_url_lfr')).host,
        port: Uri.parse(GlobalConfiguration().getValue('base_url_lfr')).port,
        path: _path + path);
    return uri;
  }

  // Uri para API de CARWASH
  static Uri getUriWash(String path) {
    String _path =
        Uri.parse(GlobalConfiguration().getValue('api_base_url_wash')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().getValue('api_base_url_wash'))
            .scheme,
        host:
            Uri.parse(GlobalConfiguration().getValue('api_base_url_wash')).host,
        port:
            Uri.parse(GlobalConfiguration().getValue('api_base_url_wash')).port,
        path: _path + path);
    return uri;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: CircularLoadingWidget(texto: 'Cargando...', height: 200),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      loader.remove();
    });
  }
}
