import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:carwash/src/models/cliente.dart';
import '../repository/user_repository.dart' as repository;
import '../repository/cliente_repository.dart';

class ClienteController extends ControllerMVC {
  GlobalKey<ScaffoldState>? scaffoldKey;
  GlobalKey<FormState>? loginFormKey;
  Cliente cliente = new Cliente();

  // OverlayEntry loader;
  ClienteController() {
    // loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.loginFormKey = new GlobalKey<FormState>();
  }

  void registrar(BuildContext context) async {
    cliente.id = "0";
    cliente.codigoCliente = repository.currentUser!.value.uid;
    cliente.estado = "1";

    FocusScope.of(context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      // Overlay.of(context).insert(loader);
      guardarCliente(cliente).then((value) {
        if (value != null) {
          Navigator.pop(context);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Ocurrio un error al Registrar, intente nuevamente!'),
          ));
        }
      }).catchError((e) {
        // loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('No se registro, intente nuevamente'),
        ));
      }).whenComplete(() {
        // Helper.hideLoader(loader);
      });
    }
  }

  void actualizar(BuildContext context) async {
    cliente.id = "0";
    cliente.codigoCliente = repository.currentUser!.value.uid;
    cliente.estado = "1";

    FocusScope.of(context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      // Overlay.of(context).insert(loader);
      actualizarCliente(cliente).then((value) {
        if (value != null) {
          Navigator.pop(context);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Ocurrio un error al Registrar, intente nuevamente!'),
          ));
        }
      }).catchError((e) {
        // loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('No se registro, intente nuevamente'),
        ));
      }).whenComplete(() {
        // Helper.hideLoader(loader);
      });
    }
  }
}
