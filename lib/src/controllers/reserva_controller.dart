import 'dart:convert';
import 'dart:io';
import 'package:carwash/src/models/atencion.dart';
import 'package:carwash/src/models/detalle_reserva.dart';
import 'package:carwash/src/models/horas.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/en_vivo_page.dart';
import 'package:carwash/src/pages/servicio_page.dart';
import 'package:carwash/src/repository/atencion_repository.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';

class ReservaController extends ControllerMVC {
  var platform = MethodChannel("example/procare");
  String hiText = "";

  int? selectedIndex;
  Atencion atencion = new Atencion();
  Reserva? reserva;
  ReservaInner? resInner;
  List<ReservaInner> reservasInner = [];
  List<DetalleReserva> ldetalleReserva = []; // Listado de detalle de reserva

  List<Horas> horas = [];
  File? fileImgFac = null;
  File? fileImgFin = null;

  Horas hora = new Horas();

  String strReserva = '';
  Map<String, dynamic> reservaCompleta = {
    "vehiculo": "",
    "servicios": "",
    "fecha": ""
  };

  double? subTotal = 0.0;
  double? total = 0.0;

  bool tieneImgFac = false;
  bool tieneImgFin = false;

  VehiculoA vehiculoElegido = new VehiculoA();
  List<Servicio> servicioElegido = [];
  Reserva fechaHoraElegida = new Reserva();

  GlobalKey<ScaffoldState>? scaffoldKey;

  String progress = "-";
  ReservaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarReservasInnerByIdCli();
  }

  String rutaImg(String nombre) {
    return getRutaImg(nombre);
  }

  void verificaInformacion(BuildContext context) async {
    String strVehiculo = await getVehiculo();
    String? strServicios = await getServicio();
    if (strVehiculo == null) {
      Navigator.pop(context);
      Navigator.of(context).push(
        new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new CarroPage(switchValue: null, valueChanged: null);
            },
            fullscreenDialog: true),
      );
    }
    if (strServicios == null) {
      Navigator.pop(context);
      Navigator.of(context).push(
        new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return new ServicioPage(switchValue: null, valueChanged: null);
            },
            fullscreenDialog: true),
      );
    }
  }

  void obtenerServicio() async {
    String? servicio_json = await getServicio();
    if (servicioElegido == null) {
      print('Es nulo');
    } else {
      final servicios = json.decode(servicio_json!);
      servicioElegido = (servicios as List)
          .map((data) => new Servicio.fromJson(data))
          .toList();
      calculateSubTotal();
    }
  }

  void obtenerVehiculo() async {
    String vehiculo_json = await getVehiculo();
    if (vehiculo_json == null) {
      vehiculoElegido = new VehiculoA();
    } else {
      vehiculoElegido = VehiculoA.fromJson(jsonDecode(vehiculo_json));
    }
    // print(jsonEncode(vehiculoElegido));
  }

  void obtenerFechaHora() async {
    String? fecha_json = await getReserva();
    if (fecha_json == null) {
      fechaHoraElegida = new Reserva();
    } else {
      fechaHoraElegida = Reserva.fromJson(jsonDecode(fecha_json));
      fechaHoraElegida.fechaReserva =
          fechaHoraElegida.fechaReserva.substring(0, 10);
    }
  }

  void eligeReserva(Reserva reserv) async {
    this.reserva = reserv;
    String strRes = reservaToJson(reserva!);
    setReserva(strRes);
    print('_________en string____________');
    print(await getReserva());
  }

  void setReservaCompleta(BuildContext context) async {
    String strVehiculo = await getVehiculo();
    this.reservaCompleta["vehiculo"] = json.decode(strVehiculo);
    String? strServicios = await getServicio();
    this.reservaCompleta["servicios"] = json.decode(strServicios!);
    String? strFecha = await getReserva();
    this.reservaCompleta["fecha"] = json.decode(strFecha!);
    print(json.encode(this.reservaCompleta));
    print('--------respuesta del post:----------');
    var respuesta = registrarReserva(json.encode(this.reservaCompleta));
    Navigator.of(context).pushReplacementNamed('/ConfirmacionReserva');
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Todavia no!",
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Si",
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      onPressed: () {
        setReservaCompleta(context);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmar Reserva"),
      content: Text("Deseas finalizar la Reserva?"),
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

  void abrirEnVivo(BuildContext context, Atencion _atencion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnVivoPage(
          atencion: _atencion,
        ),
      ),
    );
  }

// Obtener Atención por codigo de Reserva
  void obtenerAtencionPorReserva(BuildContext context, String idReserva) async {
    if (resInner!.estado != 'P') {
      final Stream<Atencion> stream = await getAtencionesPorReserva(idReserva);
      stream.listen((Atencion _atencion) {
        setState(() {
          atencion = _atencion;
          print(atencion.facturaEnviada);
        });
      }, onError: (a) {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text('No se pudo traer la información de la atención!'),
        ));
      }, onDone: () {});
    }
  }

  //listar reservas para mostrar
  void listarReservasInnerByIdCli() async {
    final Stream<List<ReservaInner>> stream =
        await obtenerReservasInnerXIdCli();
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de Internet'),
      ));
    }, onDone: () {});
  }

  //listar reservas para mostrar
  void listadoDetalleReservaPorId(String id_detalle_reserva) async {
    final Stream<List<DetalleReserva>> stream =
        await obtenerDetalleReservaPorId(id_detalle_reserva);
    stream.listen((List<DetalleReserva> _detallereserva) {
      setState(() {
        ldetalleReserva = _detallereserva;
        // print("===============================");
        // //print(carros);
        calculateTotal();
        print(jsonEncode(ldetalleReserva));
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de Internet'),
      ));
    }, onDone: () {});
  }

  void calculateTotal() async {
    subTotal = 0;
    total = 0;

    ldetalleReserva.forEach(
      (serv) {
        subTotal = (subTotal! + double.parse(serv.precio!));
      },
    );
    total = subTotal;
    setState(() {});
  }

  void calculateSubTotal() async {
    subTotal = 0;
    total = 0;

    servicioElegido.forEach(
      (serv) {
        if (vehiculoElegido.tamanio == 'M') {
          subTotal = subTotal! + double.parse(serv.precioM!);
        } else if (vehiculoElegido.tamanio == 'L') {
          subTotal = subTotal! + double.parse(serv.precioL!);
        } else {
          subTotal = subTotal! + double.parse(serv.precioXl!);
        }
      },
    );
    total = subTotal;
    setState(() {});
  }

  Future<void> alertDialogPendiente(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reserva Pendiente'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Reserva Pendiente.'),
                Text('No existe información sobre la atención de esta reserva'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Volver'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> alertDialogFacturas(BuildContext context,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Factura de Reserva'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                atencion.facturaEnviada == "1"
                    ? Image.file(fileImgFac!)
                    : Text('Todavía no esta lista tu factura.'),
              ],
            ),
          ),
          actions: <Widget>[
            atencion.facturaEnviada == "0"
                ? Container()
                : ElevatedButton.icon(
                    icon: Icon(Icons.download),
                    label: Text('Descargar'),
                    onPressed: () {
                      descargarFactura(flutterLocalNotificationsPlugin);
                    },
                  ),
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> descargarFactura(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // String fileUrl =
    //    "http://190.104.26.90:8082/lafarnetservice/api/boletapago/638_202109";
    final String fileUrl =
        '${GlobalConfiguration().getString('img_capturas_carwash') + '161'}/factura.jpg';
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    try {
      var directorio = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationSupportDirectory();
      String directorioDescargas = directorio!.path + "/factura.jpg";

      Response response = await Dio().download(fileUrl, directorioDescargas,
          onReceiveProgress: _onReceiveProgress);

      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = directorioDescargas;
      OpenFile.open(directorioDescargas);
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result, flutterLocalNotificationsPlugin);
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    const IOSNotificationDetails iOS = IOSNotificationDetails();
    const NotificationDetails platform =
        NotificationDetails(android: android, iOS: iOS); // ( android , iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Correcto!' : 'Error',
        isSuccess
            ? 'Su boleta de pago fue descargado correctamente, puede ver directamente presionando aqui!'
            : 'A ocurrido un error mientras se descargaba el archivo.',
        platform,
        payload: json);
  }

  Future<void> alertDialogVideo(BuildContext context) async {
    print(resInner!.estado);
    if (resInner!.estado == 'L') {
      abrirEnVivo(context, atencion);
      //obtenerAtencionPorReserva(context, resInner!.id!);
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ver video lavado'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  // Text('No existe la factura.'),
                  // Text('Intente, mas adelante'),

                  Text(
                      'Solo puede utilizar esta funcionalidad cuando su vehículo este en proceso de lavado.'), //.network ('http://190.104.26.90/apicwash/assets/capturas_vehiculos/'+ +'/factura.jpg')
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void launchURLVideo() async {
    const url =
        'https://www.skylinewebcams.com/en/webcam/united-states/new-york/new-york/new-york-skyline.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> listarReservasPorFecha(String fecha_seleccionada) async {
    // print("Fecha de la Reserva");
    // FocusScope.of(context).unfocus();
    // Overlay.of(context).insert(loader);
    final Stream<List<ReservaInner>> stream =
        await obtenerReservasPorFecha(fecha_seleccionada);
    stream.listen((List<ReservaInner> _reservas) {
      setState(() {
        reservasInner = _reservas;
        listarHorarioHoy();
      });
    }, onError: (a) {
      // loader.remove();
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener reservas'),
      ));
    }, onDone: () {
      // Helper.hideLoader(loader);
      // if (message != null) {
      //   scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text(message),
      //   ));
      // }
    });
  }

  Future<void> listarHorarioHoy() async {
    // FocusScope.of(context).unfocus();
    // Overlay.of(context).insert(loader);
    List<Horas> nuevo_horario = [];
    List<ReservaInner> lreservas = [];
    lreservas = reservasInner;

    final Stream<List<Horas>> stream = await obtenerHorarios();
    stream.listen((List<Horas> _horas) {
      setState(() {
        horas = _horas;
        horas.forEach((_hora) {
          Horas hora = new Horas();
          hora = _hora;
          int count = 0;
          lreservas.forEach((_reservas) {
            if (_hora.hora == _reservas.horaReserva) {
              count++;
            }
          });
          if (count == 0) {
            hora.dia = "0";
            nuevo_horario.add(hora);
          }
          // print(jsonEncode(hora));
        });
        horas = nuevo_horario;
        // print(jsonEncode(nuevo_horario));
      });
    }, onError: (a) {
      // loader.remove();
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener las horas'),
      ));
    }, onDone: () {
      // Helper.hideLoader(loader);
    });
  }

  Future<bool> isDataExist(String value) async {
    bool result = false;
    reservasInner.forEach((element) {
      if (element.horaReserva == value) {
        result = true;
      }
    });
    return result;
  }

  deseleccionarHoras() {
    // List<Horas> aux_horas = [];
    horas.forEach((element) {
      if (element == hora) {
      } else {
        element.esSeleccionado = false;
      }
    });
    setState(() {});
  }

  String obtieneFechaActual() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return date.toString();
  }

  compartirReserva() async {
    String? response;
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
      hiText = response!;
      print(hiText);
    });
  }

  obtieneImg(String idReserva) async {
    final String url =
        '${GlobalConfiguration().getString('img_capturas_carwash') + idReserva}/factura.jpg';

    final client = http.Client();
    final response = await client.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        this.tieneImgFac = true;
        var directorio = await getApplicationDocumentsDirectory();
        fileImgFac = new File(directorio.path + '/factura.jpg');
        fileImgFac!.writeAsBytesSync(response.bodyBytes);
        //final bytes = base64.decode(base64.encode(response.bodyBytes));
        //Image image = ima. (file.readAsBytesSync());

        // print(base64.encode(response.bodyBytes));
      } else {
        this.tieneImgFac = false;
      }
    } catch (e) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }
  }

  obtieneImgFinal(String idReserva) async {
    final String url =
        '${GlobalConfiguration().getString('img_capturas_carwash') + idReserva}/final.jpg';

    final client = http.Client();
    final response = await client.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        this.tieneImgFin = true;
        var directorio = await getApplicationDocumentsDirectory();
        fileImgFin = new File(directorio.path + '/final.jpg');
        fileImgFin!.writeAsBytesSync(response.bodyBytes);
        //final bytes = base64.decode(base64.encode(response.bodyBytes));
        //Image image = ima. (file.readAsBytesSync());
        // print(base64.encode(response.bodyBytes));
      } else {
        this.tieneImgFin = false;
      }
    } catch (e) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Verifica tu conexión de internet!'),
      ));
    }
  }

  Future<void> alertDialogFinal(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Final de atención'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('No existe la factura.'),
                // Text('Intente, mas adelante'),
                this.tieneImgFin
                    ? Text('')
                    : Text('El proceso de lavado continua'),
                this.tieneImgFin
                    ? Image.file(fileImgFin!)
                    : Text(
                        'Vuelva a intentar, mas adelante'), //.network ('http://190.104.26.90/apicwash/assets/capturas_vehiculos/'+ +'/factura.jpg')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
