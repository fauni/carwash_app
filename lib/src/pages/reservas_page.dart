//import 'package:cached_network_image/cached_network_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../widgets/CircularLoadingWidget.dart';

class ReservasPage extends StatefulWidget {
  // ReservasPage({@required this.switchValue, @required this.valueChanged});

  // final bool switchValue;
  // final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return ReservasPageState();
  }
}

class ReservasPageState extends StateMVC<ReservasPage> {
  bool selected = false;
  ReservaController _con;

  // bool _switchValue;

  ReservasPageState() : super(ReservaController()) {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Mis Reservas'),
        leading: new IconButton(
          icon: new Icon(Icons.clear, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Stack(children: [
        Image.asset(
          'assets/img/fondo_car.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              _con.reservasInner.isEmpty
                  ? CircularLoadingWidget(
                      height: 50,
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: _con.reservasInner.elementAt(index).estado ==
                                  'E'
                              ? Image.asset('assets/img/auto_proceso.png')
                              : CachedNetworkImage(
                                  imageUrl: _con.rutaImg(
                                    _con.reservasInner.elementAt(index).foto,
                                  ),
                                  /************* */
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                          width: 55.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          )),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                          title: Text(
                            _con.reservasInner.elementAt(index).placa,
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          subtitle: Text(
                            _con.reservasInner.elementAt(index).marca +
                                ', ' +
                                _con.reservasInner.elementAt(index).modelo +
                                '\n' +
                                _con.reservasInner
                                    .elementAt(index)
                                    .fechaReserva +
                                ' ' +
                                _con.reservasInner.elementAt(index).horaReserva,
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          trailing: FaIcon(
                            FontAwesomeIcons.caretRight,
                            color: Theme.of(context).hintColor,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/DetalleReserva',
                              arguments: new RouteArgument(
                                  id: _con.reservasInner.elementAt(index).id,
                                  param: [
                                    _con.reservasInner.elementAt(index),
                                    'Detalle'
                                  ]),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: _con.reservasInner.length,
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
