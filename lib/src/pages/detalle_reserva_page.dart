import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/pages/compartir_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:carwash/src/pages/atencion_page.dart';
import 'package:carwash/src/widgets/circular_loading_widget.dart';

class DetalleReservaPage extends StatefulWidget {
  RouteArgument? routeArgument;
  String? _heroTag;

  DetalleReservaPage({Key? key, this.routeArgument}) {
    _heroTag = this.routeArgument!.param[1] as String;
  }

  @override
  _DetalleReservaPageState createState() => _DetalleReservaPageState();
}

class _DetalleReservaPageState extends StateMVC<DetalleReservaPage>
    with SingleTickerProviderStateMixin {
  late ReservaController _con;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  ReservaInner? reserva;
  _DetalleReservaPageState() : super(ReservaController()) {
    _con = controller as ReservaController;
  }

  @override
  void initState() {
    _con.resInner = this.widget.routeArgument!.param[0];
    _con.listadoDetalleReservaPorId(widget.routeArgument!.id!);
    _con.obtenerAtencionPorReserva(context, widget.routeArgument!.id!);
    _con.obtieneImg(widget.routeArgument!.id!);
    _con.obtieneImgFinal(widget.routeArgument!.id!);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    _requestPermission();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Detalle de mi Reserva'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(
          //     icon: Icon(Icons.share),
          //     onPressed: () {
          //       Navigator.pop(context);
          //       Navigator.of(context).pushNamed('/Compartir',
          //           arguments: widget.routeArgument.id);
          //     })
        ],
        // title: Text(widget.routeArgument.id),
      ),
      body: _con.ldetalleReserva == null
          ? CircularLoadingWidget(height: 500)
          : Stack(
              children: [
                Image.asset(
                  'assets/img/fondo_car.png',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehículo Seleccionado',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 15),
                            ),
                            Text(
                              widget.routeArgument!.param[0].marca +
                                  ' ' +
                                  widget.routeArgument!.param[0].modelo,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18),
                            ),
                            Text(
                              'Placa: ' + widget.routeArgument!.param[0].placa,
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Servicios',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Column(
                              children: [
                                for (var item in _con.ldetalleReserva)
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(item.nombre!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w200,
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      ),
                                      Text(
                                          'Bs. ' +
                                              (double.parse(item.precio!))
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .accentColor))
                                    ],
                                  )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Total Servicio',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w200,
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                                Text('Bs. ' + _con.total.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).accentColor))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Fecha',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Theme.of(context).hintColor)),
                            ),
                            Text(
                                widget.routeArgument!.param[0].fechaReserva +
                                    ' ' +
                                    widget.routeArgument!.param[0].horaReserva,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (widget.routeArgument!.param[0].estado ==
                                  'P') {
                                _con.alertDialogPendiente(context);
                              } else {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AtencionPage(
                                      routeArgument: RouteArgument(
                                          id: widget.routeArgument!.id,
                                          param: [
                                            widget.routeArgument!.param[0],
                                            widget._heroTag
                                          ]),
                                    ),
                                  ),
                                );

                                if (result != null) {
                                  if (result) {
                                    // widget.onDismissed.call();
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Theme.of(context).accentColor),
                              ),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/mis_fotos.png',
                                    width: 60,
                                  ),
                                  Text(
                                    'Ver Capturas',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => _con.alertDialogVideo(
                                context), //_con.launchURLVideo(),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              // height: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Theme.of(context).accentColor),
                              ),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/en_vivo.png',
                                    width: 60,
                                  ),
                                  Text(
                                    'Ver en Vivo',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              _con.obtieneImg(widget.routeArgument!.id!);
                              _con.alertDialogFacturas(
                                  context, flutterLocalNotificationsPlugin);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              // height: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Theme.of(context).accentColor),
                              ),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/mi_factura.png',
                                    width: 60,
                                  ),
                                  Text(
                                    'Mi Factura',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widget.routeArgument!.param[0].estado == 'L'
                              ? Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  // height:MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).hintColor,
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Theme.of(context).accentColor),
                                  ),
                                  child: Image.asset(
                                      'assets/img/en_proceso_white.png',
                                      width: 60,
                                      height: 80),
                                )
                              : widget.routeArgument!.param[0].estado == 'F'
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      // height: MediaQuery.of(context).size.height /8,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        //border: Border.all(color: Theme.of(context).accentColor),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _con.obtieneImgFinal(
                                              widget.routeArgument!.id!);
                                          _con.alertDialogFinal(context);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/img/en_proceso.png',
                                              width: 60,
                                            ),
                                            Text(
                                              'Finalizado',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      // height: MediaQuery.of(context).size.height /8,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.circular(20),
                                        //border: Border.all(color: Theme.of(context).accentColor),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/img/isotipo.png',
                                            width: 50,
                                          ),
                                          Text(
                                            'Pendiente',
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      ),
                                    )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.routeArgument!.param[0].estado == 'F'
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ButtonTheme(
                                minWidth: double.infinity,
                                height: 50.0,
                                child: RaisedButton.icon(
                                  onPressed: () {
                                    print(jsonEncode(
                                        widget.routeArgument!.param[0].id));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CompartirPage(
                                                idReserva: widget.routeArgument!
                                                    .param[0].id)));
                                    // Navigator.of(context).pushNamed(
                                    //     '/Compartir',
                                    //     arguments: widget.routeArgument.id);
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Theme.of(context).hintColor,
                                  icon: Icon(Icons.share),
                                  label: Text('Compartir Reserva'),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }

  Future<void> _onSelectNotification(dynamic json) async {
    final obj = jsonDecode(json);
    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('error'),
                content: Text('${obj['error']}'),
              ));
    }
    // todo: handling clicked notification
  }
}

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? heroTag;

  const DetailScreen({Key? key, this.image, this.heroTag}) : super(key: key);

  @override
  _DetailScreenWidgetState createState() => _DetailScreenWidgetState();
}

class _DetailScreenWidgetState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        child: Hero(
            tag: widget.heroTag!,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.image!),
            )),
      ),
    ));
  }
}
