import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/atencion.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/widgets/CircularLoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:photo_view/photo_view.dart';
import 'package:carwash/src/pages/atencion_page.dart';

class DetalleReservaPage extends StatefulWidget {
  RouteArgument routeArgument;
  String _heroTag;

  DetalleReservaPage({Key key, this.routeArgument}) {
    _heroTag = this.routeArgument.param[1] as String;
  }

  @override
  _DetalleReservaPageState createState() => _DetalleReservaPageState();
}

class _DetalleReservaPageState extends StateMVC<DetalleReservaPage>
    with SingleTickerProviderStateMixin {
  ReservaController _con;
  ReservaInner reserva;
  _DetalleReservaPageState() : super(ReservaController()) {
    _con = controller;
  }

  @override
  void initState() {
    // _con.listenForProduct(productId: widget.routeArgument.id);

    // _con.listarCarrito();
    // print(
    //   jsonEncode(this.widget.routeArgument.param[0]),
    // );

    _con.resInner = this.widget.routeArgument.param[0];
    _con.listadoDetalleReservaPorId(widget.routeArgument.id);
    _con.obtieneImg(widget.routeArgument.id);
    _con.obtieneImgFinal(widget.routeArgument.id);
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
        title: Text('Detalle de la Reserva'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Navigator.of(context)
                .pushNamed('/Compartir', arguments: widget.routeArgument.id),
          )
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        padding: EdgeInsets.only(left: 20),
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
                              this.widget.routeArgument.param[0].marca +
                                  ' ' +
                                  this.widget.routeArgument.param[0].modelo,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18),
                            ),
                            Text(
                              'Placa: ' +
                                  this.widget.routeArgument.param[0].placa,
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
                                        child: Text(item.nombre,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w200,
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      ),
                                      Text(
                                          'Bs. ' +
                                              (double.parse(item.precio))
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
                                this
                                        .widget
                                        .routeArgument
                                        .param[0]
                                        .fechaReserva +
                                    ' ' +
                                    this
                                        .widget
                                        .routeArgument
                                        .param[0]
                                        .horaReserva,
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
                              if (widget.routeArgument.param[0].estado == 'P') {
                                _con.alertDialogPendiente();
                              } else {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AtencionPage(
                                      routeArgument: new RouteArgument(
                                          id: widget.routeArgument.id,
                                          param: [
                                            widget.routeArgument.param[0],
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
                              height: MediaQuery.of(context).size.height / 8,
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
                            onTap: () => _con
                                .alertDialogVideo(), //_con.launchURLVideo(),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 8,
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
                              // _con.obtieneImg(widget.routeArgument.id);
                              _con.alertDialogFacturas();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 8,
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
                          widget.routeArgument.param[0].estado == 'L'
                              ? Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).hintColor,
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Theme.of(context).accentColor),
                                  ),
                                  child: Image.asset(
                                    'assets/img/en_proceso_white.png',
                                    width: 60,
                                  ),
                                )
                              : widget.routeArgument.param[0].estado == 'F'
                                  ? Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        //border: Border.all(color: Theme.of(context).accentColor),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _con.obtieneImgFinal(
                                              widget.routeArgument.id);
                                          _con.alertDialogFinal();
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
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
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String image;
  final String heroTag;

  const DetailScreen({Key key, this.image, this.heroTag}) : super(key: key);

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
            tag: widget.heroTag,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.image),
            )),
      ),
    ));
  }
}
