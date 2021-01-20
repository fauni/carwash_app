import 'dart:convert';
import 'dart:io';

import 'package:carwash/src/helpers/helper.dart';
import 'package:carwash/src/models/atencion.dart';
import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/detalle_reserva.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/repository/atencion_repository.dart';
import 'package:carwash/src/repository/cliente_repository.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AtencionController extends ControllerMVC {
  String imgLeft = '';
  String imgRigth = '';
  String imgFront = '';
  String imgBack = '';

  bool seInicio = false;
  OverlayEntry loader;

  List<DetalleReserva> ldetalleReserva = []; // Listado de detalle de reserva
  Cliente cliente = new Cliente();
  Atencion atencion = new Atencion();
  ReservaInner reserva = new ReservaInner();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  double subTotal = 0.0;
  double total = 0.0;

  File carLeft;
  File carRigth;
  File carFront;
  File carBack;
  final picker = ImagePicker();
  List<String> limages = [];

  AtencionController() {
    loader = Helper.overlayLoader(context);
  }

  String rutaImg(String nombre) {
    return getRutaImg(nombre);
  }

  void obtenerRutasImagenes() async {
    final url_capturas = await getUrlCapturas();
    setState(() {
      this.imgLeft = url_capturas + reserva.id + '/left.jpg';
      this.imgRigth = url_capturas + reserva.id + '/rigth.jpg';
      this.imgFront = url_capturas + reserva.id + '/front.jpg';
      this.imgBack = url_capturas + reserva.id + '/back.jpg';
    });
  }

  Future getImageCar(String lado) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        if (lado == 'L') {
          carLeft = File(pickedFile.path);
          limages.add(pickedFile.path);
        } else if (lado == 'R') {
          carRigth = File(pickedFile.path);
          limages.add(pickedFile.path);
        } else if (lado == 'F') {
          carFront = File(pickedFile.path);
          limages.add(pickedFile.path);
        } else {
          carBack = File(pickedFile.path);
          limages.add(pickedFile.path);
        }
      } else {
        print('Image no seleccionada.');
      }
    });
  }

  Future quitarImagen(String lado) {
    setState(() {
      if (lado == 'L') {
        carLeft = null;
      } else if (lado == 'R') {
        carRigth = null;
      } else if (lado == 'F') {
        carFront = null;
      } else {
        carBack = null;
      }
    });
  }
  //listar reservas para mostrar
  // Future<void> listarReservasInnerCurrent({String message}) async {
  //   final Stream<List<ReservaInner>> stream =
  //       await obtenerReservasInnerCurrent();
  //   stream.listen((List<ReservaInner> _reservas) {
  //     setState(() {
  //       if (currentUser.value.email == null) {
  //         Navigator.of(context).pushNamed('/Login');
  //       }
  //       reservasInner = _reservas;
  //       print('actualizado');
  //     });
  //   }, onError: (a) {
  //     scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener reservas'),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }

//listar reservas para mostrar
  void listadoDetalleReservaPorId(String id_reserva) async {
    final Stream<List<DetalleReserva>> stream =
        await obtenerDetalleReservaPorId(id_reserva);
    stream.listen((List<DetalleReserva> _detallereserva) {
      setState(() {
        ldetalleReserva = _detallereserva;
        // print("===============================");
        // //print(carros);
        calculateTotal();
        // print(jsonEncode(ldetalleReserva));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }, onDone: () {});
  }

  // listar cliente por Email
  void listadoClientePorEmail(String email) async {
    final Stream<Cliente> stream = await obtenerClienteXEmail(email);
    stream.listen((Cliente _cliente) {
      setState(() {
        cliente = _cliente;
        // print("===============================");
        // //print(carros);
        // print(jsonEncode(cliente));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }, onDone: () {});
  }

  // Obtener Atención por codigo de Reserva
  void obtenerAtencionPorReserva(String idReserva) async {
    final Stream<Atencion> stream = await getAtencionesPorReserva(idReserva);
    stream.listen((Atencion _atencion) {
      setState(() {
        atencion = _atencion;
        // print('==========================');
        // print(json.encode(atencion));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No se pudo traer la información de la atención!'),
      ));
    }, onDone: () {});
  }

  void calculateTotal() async {
    subTotal = 0;
    total = 0;

    ldetalleReserva.forEach(
      (serv) {
        subTotal = subTotal + double.parse(serv.precio);
      },
    );
    total = subTotal;
    setState(() {});
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Continuar Lavando"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Finalizar"),
      onPressed: () {
        finalizarAtencion();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Finalizar Lavado"),
      content: Text("Deseas finalizar el proceso de lavado?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // listar cliente por Email
  void finalizarAtencion() async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);

    final Stream<bool> stream = await finishAtencion(atencion);
    stream.listen((bool _seInicio) {
      setState(() {
        seInicio = _seInicio;
        if (seInicio) {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Se finalizo el proceso de Lavado'),
            ),
          );
          obtenerAtencionPorReserva(atencion.idReserva);
          // Navigator.pop(context, true);
        } else {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                  'Revise la información, no se pudo iniciar el proceso de lavado'),
            ),
          );
        }

        // print("===============================");
        // //print(carros);
      });
    }, onError: (a) {
      loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }, onDone: () {
      Helper.hideLoader(loader);
    });
  }
  // Future<void> refreshHome() async {
  //   setState(() {
  //     reservasInner = <ReservaInner>[];
  //   });
  //   await listarReservasInnerCurrent();
  // }
}
