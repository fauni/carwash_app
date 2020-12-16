import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ServiciosWidget extends StatefulWidget {
  ServiciosWidget();

  @override
  State<StatefulWidget> createState() => ServiciosWidgetState();
}

class ServiciosWidgetState extends StateMVC<ServiciosWidget> {
  ServicioController _con;

  String tipoAuto = 'L';
  ServiciosWidgetState() : super(ServicioController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(left: 10, right: 15, top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).accentColor)),
              child: Column(
                children: [
                  Text(_con.serviciosGeneral.elementAt(index).nombre),
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
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
