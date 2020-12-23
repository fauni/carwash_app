//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ServicioPage extends StatefulWidget {
  ServicioPage({@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return ServicioPageState();
  }
}

class ServicioPageState extends StateMVC<ServicioPage> {
  bool selected = false;

  String tipoAuto = 'L';
  ServicioController _con;

  // bool _switchValue;

  ServicioPageState() : super(ServicioController()) {
    _con = controller;
  }
  @override
  void initState() {
    // _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  margin: EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      'Seleccione los Servicios',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _con.serviciosGeneral.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        highlightColor: Theme.of(context).primaryColor,
                        hoverColor: Theme.of(context).primaryColor,
                        onTap: () {
                          print(_con.serviciosGeneral.elementAt(index).nombre);
                          _con.insertaServElegidos(
                              _con.serviciosGeneral.elementAt(index));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.only(left: 10, right: 15, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Column(
                            children: [
                              Text(
                                _con.serviciosGeneral.elementAt(index).nombre,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor),
                              ),
                              if (this.tipoAuto == 'M')
                                Text(
                                  double.parse(_con.serviciosGeneral
                                              .elementAt(index)
                                              .precioM)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'L')
                                Text(
                                  double.parse(_con.serviciosGeneral
                                              .elementAt(index)
                                              .precioL)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'XL')
                                Text(
                                  double.parse(_con.serviciosGeneral
                                              .elementAt(index)
                                              .precioXl)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              Text(
                                _con.serviciosGeneral.elementAt(index).detalle,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  margin: EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      'Servicios Adicionales',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _con.serviciosAdicionales.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        highlightColor: Theme.of(context).primaryColor,
                        hoverColor: Theme.of(context).primaryColor,
                        onTap: () {
                          print(_con.serviciosAdicionales
                              .elementAt(index)
                              .nombre);
                          _con.insertaServElegidos(
                              _con.serviciosAdicionales.elementAt(index));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.only(left: 10, right: 15, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Column(
                            children: [
                              Text(
                                _con.serviciosAdicionales
                                    .elementAt(index)
                                    .nombre,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor),
                              ),
                              if (this.tipoAuto == 'M')
                                Text(
                                  double.parse(_con.serviciosAdicionales
                                              .elementAt(index)
                                              .precioM)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'L')
                                Text(
                                  double.parse(_con.serviciosAdicionales
                                              .elementAt(index)
                                              .precioL)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'XL')
                                Text(
                                  double.parse(_con.serviciosAdicionales
                                              .elementAt(index)
                                              .precioXl)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              Text(
                                _con.serviciosAdicionales
                                    .elementAt(index)
                                    .detalle,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  margin: EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      'Servicio para Motos',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _con.serviciosMotos.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        highlightColor: Theme.of(context).primaryColor,
                        hoverColor: Theme.of(context).primaryColor,
                        onTap: () {
                          print(_con.serviciosMotos.elementAt(index).nombre);
                          _con.insertaServElegidos(
                              _con.serviciosMotos.elementAt(index));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.only(left: 10, right: 15, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Column(
                            children: [
                              Text(
                                _con.serviciosMotos.elementAt(index).nombre,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor),
                              ),
                              if (this.tipoAuto == 'M')
                                Text(
                                  double.parse(_con.serviciosMotos
                                              .elementAt(index)
                                              .precioM)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'L')
                                Text(
                                  double.parse(_con.serviciosMotos
                                              .elementAt(index)
                                              .precioL)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              if (this.tipoAuto == 'XL')
                                Text(
                                  double.parse(_con.serviciosMotos
                                              .elementAt(index)
                                              .precioXl)
                                          .toString() +
                                      '.Bs',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              Text(
                                _con.serviciosMotos.elementAt(index).detalle,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Text(
                    'Total del Servicio: 500.00 Bs.',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
