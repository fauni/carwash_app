import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/producto.dart';
import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/producto_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CarroController extends ControllerMVC {
  Setting setting = new Setting();
  String nombre = 'ERTIGA';

  List<Producto> productos = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  CarroController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarProductos();
  }

  void listarProductos({String message}) async {
    final Stream<List<Producto>> stream = await obtenerProductos();
    stream.listen((List<Producto> _productos) {
      setState(() {
        productos = _productos;
        print("===============================");
        print(productos);
        // print(json.encode(favoritos));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
}
