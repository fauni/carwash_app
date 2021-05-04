import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva_inner.dart';
import 'package:carwash/src/widgets/CircularLoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ConfirmarReservaPage extends StatefulWidget {
  ConfirmarReservaPage({Key key}) {}

  @override
  _ConfirmarReservaPageState createState() => _ConfirmarReservaPageState();
}

class _ConfirmarReservaPageState extends StateMVC<ConfirmarReservaPage>
    with SingleTickerProviderStateMixin {
  ReservaController _con;

  ReservaInner reserva;
  _ConfirmarReservaPageState() : super(ReservaController()) {
    _con = controller;
  }

  @override
  void initState() {
    // _con.listadoDetalleReservaPorId(widget.routeArgument.id);
    // _con.obtieneImg(widget.routeArgument.id);
    // _con.obtieneImgFinal(widget.routeArgument.id);
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
        // title: Text(widget.routeArgument.id),
      ),
      body: _con.ldetalleReserva == null
          ? CircularLoadingWidget(height: 500)
          : Stack(
              children: [
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
                              'Marca y modelo del vehiculo',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18),
                            ),
                            Text(
                              'Placa: Numero de Placa',
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
                            Text('Fecha y Hora ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 50.0,
                          child: RaisedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmarReservaPage(),
                                ),
                              );
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).hintColor,
                            icon: Image.asset(
                              'assets/img/cuando_off.png',
                              width: 50,
                            ),
                            label: Text('Confirmar la Reserva'),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 50.0,
                          child: RaisedButton.icon(
                            onPressed: () => Navigator.of(context).pop(true),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).hintColor,
                            icon: Image.asset(
                              'assets/img/isotipo.png',
                              width: 30,
                            ),
                            label: Text('Cancelar y volver al Inicio'),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
