import 'dart:convert';
import 'dart:io';

import 'package:carwash/src/models/atencion.dart';
import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/repository/atencion_repository.dart';
import 'package:carwash/src/repository/cliente_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'package:social_share_plugin/social_share_plugin.dart';

class CompartirController extends ControllerMVC {
  Atencion atencion = new Atencion();
  Cliente cliente = new Cliente();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var platform = MethodChannel("example/procare");
  String hiText = "";

  File fileImgFin = null;
  bool tieneImgFin = false;
  CompartirController() {}

// Obtener Atención por codigo de Reserva
  void obtenerAtencionPorReserva(String idReserva) async {
    final Stream<Atencion> stream = await getAtencionesPorReserva(idReserva);
    stream.listen((Atencion _atencion) {
      setState(() {
        atencion = _atencion;
        listadoClientePorEmail(_atencion.usuario);
        // obtieneImgFinal(atencion.idReserva);
        // print('==========================');
        // print(json.encode(atencion));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No se pudo traer la información de la atención!'),
      ));
    }, onDone: () {});
  }

  compartirReserva() async {
    if (Platform.isIOS) {
      // await SocialSharePlugin.shareToFeedFacebookLink(
      //     quote: 'quote', url: 'https://flutter.dev');
    } else {
      String response;
      try {
        // response = await platform.invokeMethod("hello", "https://alquiauto.es/wp-content/uploads/2020/05/limpieza-y-lavado-del-coche-DURANTE-CORONA-VIRUS.jpg");
        response =
            await platform.invokeMethod("hello", "http://procarewashing.com");
      } on Exception catch (exception) {
        print('=============================');
        print(exception);
        response = 'Comunicacion Plattforms Error!';
      } catch (error) {
        print('==============ERROR==============');
        print(error);
      }

      setState(() {
        hiText = response;
        print(hiText);
      });
    }
  }

  obtieneImgFinal(String idReserva) async {
    print("reserva: " + idReserva);
    final String url =
        '${GlobalConfiguration().getString('img_capturas_carwash') + idReserva}/final.jpg';

    final client = http.Client();
    final response = await client.get(url);
    try {
      if (response.statusCode == 200) {
        this.tieneImgFin = true;
        var directorio = await getApplicationDocumentsDirectory();
        fileImgFin = new File(directorio.path + '/final.jpg');
        fileImgFin.writeAsBytesSync(response.bodyBytes);
        setState(() {});
        //final bytes = base64.decode(base64.encode(response.bodyBytes));
        //Image image = ima. (file.readAsBytesSync());
        print(base64.encode(response.bodyBytes));
      } else {
        this.tieneImgFin = false;
      }
    } catch (e) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }
  }

  // listar cliente por Email
  void listadoClientePorEmail(String email) async {
    final Stream<Cliente> stream = await obtenerClienteXEmail(email);
    stream.listen((Cliente _cliente) {
      setState(() {
        cliente = _cliente;
        // print("===============================");
        // //print(carros);
        print(jsonEncode(cliente));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }, onDone: () {});
  }

  // void registrar() async {
  //   cliente.id = "0";
  //   cliente.codigoCliente = repository.currentUser.value.uid;
  //   cliente.estado = "1";

  //   FocusScope.of(context).unfocus();
  //   if (loginFormKey.currentState.validate()) {
  //     loginFormKey.currentState.save();
  //     Overlay.of(context).insert(loader);
  //     guardarCliente(cliente).then((value) {
  //       if (value != null) {
  //         Navigator.pop(context);
  //       } else {
  //         scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //           content: Text('Ocurrio un error al Registrar, intente nuevamente!'),
  //         ));
  //       }
  //     }).catchError((e) {
  //       loader.remove();
  //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //         content: Text('No se registro, intente nuevamente'),
  //       ));
  //     }).whenComplete(() {
  //       Helper.hideLoader(loader);
  //     });
  //   }
  // }

  // void actualizar() async {
  //   cliente.id = "0";
  //   cliente.codigoCliente = repository.currentUser.value.uid;
  //   cliente.estado = "1";

  //   FocusScope.of(context).unfocus();
  //   if (loginFormKey.currentState.validate()) {
  //     loginFormKey.currentState.save();
  //     Overlay.of(context).insert(loader);
  //     actualizarCliente(cliente).then((value) {
  //       if (value != null) {
  //         Navigator.pop(context);
  //       } else {
  //         scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //           content: Text('Ocurrio un error al Registrar, intente nuevamente!'),
  //         ));
  //       }
  //     }).catchError((e) {
  //       loader.remove();
  //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //         content: Text('No se registro, intente nuevamente'),
  //       ));
  //     }).whenComplete(() {
  //       Helper.hideLoader(loader);
  //     });
  //   }
  // }
}
