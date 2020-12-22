import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/widgets/CircularLoadingWidget.dart';
import 'package:carwash/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:photo_view/photo_view.dart';

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
    print(
      jsonEncode(this.widget.routeArgument.param[0]),
    );
    _con.listadoDetalleReservaPorId(widget.routeArgument.id);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Detalle de la Reserva'),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        padding: EdgeInsets.only(left: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Auto Seleccionado',
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
                              'Placa ' +
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
                        height: 200,
                        padding: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Servicios',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                itemCount: _con.ldetalleReserva.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            _con.ldetalleReserva
                                                .elementAt(index)
                                                .nombre,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200,
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      ),
                                      Text(
                                          'Bs. ' +
                                              _con.ldetalleReserva
                                                  .elementAt(index)
                                                  .precioM,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .accentColor))
                                    ],
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Total Servicio',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                                Text('Bs. ' + '5000.00',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).accentColor))
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        padding: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                            onTap: () {
                              print('J');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 7,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Theme.of(context).accentColor),
                              ),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/mis_reservas_blue.png',
                                    width: 80,
                                  ),
                                  Text(
                                    'Ver Fotos',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              //border: Border.all(color: Theme.of(context).accentColor),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/img/mis_reservas_blue.png',
                                  width: 80,
                                ),
                                Text(
                                  'Ver en Vivo',
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              //border: Border.all(color: Theme.of(context).accentColor),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/img/mis_reservas_blue.png',
                                  width: 80,
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
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              //border: Border.all(color: Theme.of(context).accentColor),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/img/mis_reservas_blue.png',
                                  width: 80,
                                ),
                                Text(
                                  'En Proceso',
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
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
