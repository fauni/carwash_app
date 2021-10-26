import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/pages/seleccionar_fechahora_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeleccionarServicioPage extends StatefulWidget {
  SeleccionarServicioPage();

  @override
  State<StatefulWidget> createState() {
    return SeleccionarServicioPageState();
  }
}

class SeleccionarServicioPageState extends StateMVC<SeleccionarServicioPage> {
  bool selected = false;

  String tipoAuto = 'L';
  late ServicioController _con;

  // bool _switchValue;

  SeleccionarServicioPageState() : super(ServicioController()) {
    _con = controller as ServicioController;
  }
  @override
  void initState() {
    _con.obtenerVehiculo(context);
    // tipoAuto = _con.vehiculoElegido.tamanio!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona los Servicios'),
        backgroundColor: Colors.transparent,
        actions: [
          // _con.serviciosElegidos.length > 0
          //     ? IconButton(
          //         color: Theme.of(context).hintColor,
          //         icon: Icon(Icons.check),
          //         onPressed: () => Navigator.of(context).pop(true))
          //     : Text('')
        ],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   onPressed: () {
      //     Navigator.of(context).pop(true);
      //     Navigator.of(context).push(
      //       new MaterialPageRoute<Null>(
      //           builder: (BuildContext context) {
      //             return new FechaPage(switchValue: null, valueChanged: null);
      //           },
      //           fullscreenDialog: true),
      //     );
      //   },
      //   label: Text(
      //     _con.total.toString() + 'Bs.',
      //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100),
      //   ),
      //   icon: Icon(Icons.navigate_next),
      // ),
      body: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      color: Theme.of(context).accentColor,
                    ),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: ExpansionTile(
                        title: Text(
                          'SERVICIOS GENERALES',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Seleccione un Servicio General',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            'G',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _con.serviciosGeneral.length,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Theme.of(context).accentColor),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        // value: this
                                        //     ._con
                                        //     .servicios
                                        //     .elementAt(index)
                                        //     .esSeleccionado,
                                        value: index,
                                        groupValue: _con.valueRadio,
                                        onChanged: (ind) {
                                          setState(() {
                                            _con.valueRadio = ind as int;
                                            this
                                                ._con
                                                .insertaServElegidosGeneral(_con
                                                    .serviciosGeneral
                                                    .elementAt(index));
                                          });
                                        },

                                        // onChanged: (bool elegido) {
                                        //   setState(() {
                                        //     this
                                        //         ._con
                                        //         .servicios
                                        //         .elementAt(index)
                                        //         .esSeleccionado = elegido;
                                        //     _con.insertaServElegidos(_con
                                        //         .serviciosGeneral
                                        //         .elementAt(index));
                                        //   });
                                        // },
                                        secondary: _con
                                                    .vehiculoElegido.tamanio ==
                                                'M'
                                            ? Text(
                                                double.parse(_con
                                                            .serviciosGeneral
                                                            .elementAt(index)
                                                            .precioM!)
                                                        .toString() +
                                                    '  Bs.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              )
                                            : _con.vehiculoElegido.tamanio ==
                                                    'L'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosGeneral
                                                                .elementAt(
                                                                    index)
                                                                .precioL!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0),
                                                  )
                                                : Text(
                                                    double.parse(_con
                                                                .serviciosGeneral
                                                                .elementAt(
                                                                    index)
                                                                .precioXl!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0),
                                                  ),
                                        title: Text(
                                          _con.servicios
                                              .elementAt(index)
                                              .nombre!,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        subtitle: Text(
                                          _con.servicios
                                              .elementAt(index)
                                              .detalle!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor,
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'SERVICIOS ADICIONALES',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Seleccione uno varios servicios adicionales',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        leading: CircleAvatar(
                          radius: 30.0,
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _con.serviciosAdicionales.length,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Theme.of(context).accentColor)),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                        secondary: _con
                                                    .vehiculoElegido.tamanio ==
                                                'M'
                                            ? Text(
                                                double.parse(_con
                                                            .serviciosAdicionales
                                                            .elementAt(index)
                                                            .precioM!)
                                                        .toString() +
                                                    '  Bs.',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
                                              )
                                            : _con.vehiculoElegido.tamanio ==
                                                    'L'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosAdicionales
                                                                .elementAt(
                                                                    index)
                                                                .precioL!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    double.parse(_con
                                                                .serviciosAdicionales
                                                                .elementAt(
                                                                    index)
                                                                .precioXl!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white),
                                                  ),
                                        title: Text(
                                          _con.serviciosAdicionales
                                              .elementAt(index)
                                              .nombre!,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        subtitle: Text(
                                          _con.serviciosAdicionales
                                              .elementAt(index)
                                              .detalle!,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        value: this
                                            ._con
                                            .serviciosAdicionales
                                            .elementAt(index)
                                            .esSeleccionado,
                                        onChanged: (bool? elegido) {
                                          setState(() {
                                            this
                                                ._con
                                                .serviciosAdicionales
                                                .elementAt(index)
                                                .esSeleccionado = elegido;
                                            _con.insertaServElegidosAdicional(
                                                _con.serviciosAdicionales
                                                    .elementAt(index));
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _con.serviciosElegidos.length > 0
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 50.0,
                            child: RaisedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                Navigator.of(context).push(
                                  new MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return new SeleccionarFechahoraPage(
                                            switchValue: false,
                                            valueChanged: null);
                                      },
                                      fullscreenDialog: true),
                                );
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).hintColor,
                              icon: Image.asset(
                                'assets/img/cuando_off.png',
                                width: 50,
                              ),
                              label: Text('Elejir la Fecha y Hora'),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        label: Text('Volver al Inicio'),
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
      ),
    );
  }
}
