import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DetalleServicioPage extends StatefulWidget {
  RouteArgument routeArgument;
  String _heroTag;

  DetalleServicioPage({Key key, this.routeArgument}) {
    _heroTag = this.routeArgument.param[1] as String;
  }

  @override
  _DetalleServicioPageState createState() => _DetalleServicioPageState();
}

class _DetalleServicioPageState extends StateMVC<DetalleServicioPage>
    with SingleTickerProviderStateMixin {
  ServicioController _con;

  _DetalleServicioPageState() : super(ServicioController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Text('Hola Mundo'),
      ),
    );
  }
}
