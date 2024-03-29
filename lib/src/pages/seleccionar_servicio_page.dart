import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/pages/seleccionar_fechahora_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeleccionarServicioPage extends StatefulWidget {
  String? tipoServicio;
  SeleccionarServicioPage({this.tipoServicio});

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Selecciona los Servicios'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            widget.tipoServicio == 'P'
                ? 'assets/img/fondo_car.png'
                : 'assets/img/fondo_carpro.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsets.only(top: 70, bottom: 70),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.only(top: 0, left: 20, right: 20),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: widget.tipoServicio == 'P'
                        ? Theme.of(context).hintColor
                        : Theme.of(context).accentColor,
                  ),
                  widget.tipoServicio == 'P'
                      ? Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: ExpansionTile(
                            title: Text(
                              'SERVICIOS GENERALES',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Seleccione un Servicio General',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                                                    .insertaServElegidosGeneral(
                                                        _con.serviciosGeneral
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
                                            secondary: _con.vehiculoElegido
                                                        .tamanio ==
                                                    'M'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosGeneral
                                                                .elementAt(
                                                                    index)
                                                                .precioM!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0),
                                                  )
                                                : _con.vehiculoElegido
                                                            .tamanio ==
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
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                            subtitle: Text(
                                              _con.servicios
                                                  .elementAt(index)
                                                  .detalle!,
                                              style: TextStyle(
                                                  color: Colors.white),
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
                        )
                      : Container(),
                  widget.tipoServicio == 'P'
                      ? Divider(
                          color: Theme.of(context).accentColor,
                        )
                      : Container(),
                  widget.tipoServicio == 'P'
                      ? Theme(
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
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
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
                                            color:
                                                Theme.of(context).accentColor)),
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          CheckboxListTile(
                                            secondary: _con.vehiculoElegido
                                                        .tamanio ==
                                                    'M'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosAdicionales
                                                                .elementAt(
                                                                    index)
                                                                .precioM!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white),
                                                  )
                                                : _con.vehiculoElegido
                                                            .tamanio ==
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
                                                            color:
                                                                Colors.white),
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                            title: Text(
                                              _con.serviciosAdicionales
                                                  .elementAt(index)
                                                  .nombre!,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
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
                        )
                      : Container(),
                  widget.tipoServicio == 'P'
                      ? Container()
                      : Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: ExpansionTile(
                            title: Text(
                              'LAVADOS',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Seleccione un Servicio de Lavado',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              child: Text(
                                'L',
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
                                itemCount: _con.serviciosGeneralPro.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: Colors.white),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          RadioListTile(
                                            value: index,
                                            groupValue: _con.valueRadio,
                                            onChanged: (ind) {
                                              setState(() {
                                                _con.valueRadio = ind as int;
                                                this
                                                    ._con
                                                    .insertaServElegidosGeneral(
                                                        _con.serviciosGeneralPro
                                                            .elementAt(index));
                                              });
                                            },
                                            secondary: _con.vehiculoElegido
                                                        .tamanio ==
                                                    'M'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosGeneralPro
                                                                .elementAt(
                                                                    index)
                                                                .precioM!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0),
                                                  )
                                                : _con.vehiculoElegido
                                                            .tamanio ==
                                                        'L'
                                                    ? Text(
                                                        double.parse(_con
                                                                    .serviciosGeneralPro
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
                                                                    .serviciosGeneralPro
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
                                              _con.serviciosGeneralPro
                                                  .elementAt(index)
                                                  .nombre!,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              _con.serviciosGeneralPro
                                                  .elementAt(index)
                                                  .detalle!,
                                              style: TextStyle(
                                                  color: Colors.white),
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
                  widget.tipoServicio == 'P'
                      ? Container()
                      : Divider(
                          color: Colors.grey,
                        ),
                  // widget.tipoServicio == 'P'
                  //     ? Container()
                  //     : Theme(
                  //         data: ThemeData(
                  //           unselectedWidgetColor: Colors.white,
                  //         ),
                  //         child: ExpansionTile(
                  //           title: Text(
                  //             'LAVADOS EXTRAS',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           subtitle: Text(
                  //             'Seleccione uno o varios lavados extras',
                  //             style: TextStyle(
                  //               color: Colors.grey,
                  //             ),
                  //           ),
                  //           leading: CircleAvatar(
                  //             radius: 30.0,
                  //             child: Text(
                  //               'E',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 30.0,
                  //               ),
                  //             ),
                  //             backgroundColor: Colors.grey,
                  //           ),
                  //           children: [
                  //             ListView.builder(
                  //               physics: NeverScrollableScrollPhysics(),
                  //               shrinkWrap: true,
                  //               scrollDirection: Axis.vertical,
                  //               itemCount:
                  //                   _con.serviciosLavadosExtrasPro.length,
                  //               itemBuilder: (BuildContext context, index) {
                  //                 return Card(
                  //                   color: Colors.transparent,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(20),
                  //                     side: BorderSide(
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                   child: Container(
                  //                     padding: EdgeInsets.all(10.0),
                  //                     child: Column(
                  //                       children: [
                  //                         CheckboxListTile(
                  //                           secondary: _con.vehiculoElegido
                  //                                       .tamanio ==
                  //                                   'M'
                  //                               ? Text(
                  //                                   double.parse(_con
                  //                                               .serviciosLavadosExtrasPro
                  //                                               .elementAt(
                  //                                                   index)
                  //                                               .precioM!)
                  //                                           .toString() +
                  //                                       '  Bs.',
                  //                                   style: TextStyle(
                  //                                       fontSize: 20.0,
                  //                                       color: Colors.white),
                  //                                 )
                  //                               : _con.vehiculoElegido
                  //                                           .tamanio ==
                  //                                       'L'
                  //                                   ? Text(
                  //                                       double.parse(_con
                  //                                                   .serviciosLavadosExtrasPro
                  //                                                   .elementAt(
                  //                                                       index)
                  //                                                   .precioL!)
                  //                                               .toString() +
                  //                                           '  Bs.',
                  //                                       style: TextStyle(
                  //                                           fontSize: 20.0,
                  //                                           color:
                  //                                               Colors.white),
                  //                                     )
                  //                                   : Text(
                  //                                       double.parse(_con
                  //                                                   .serviciosLavadosExtrasPro
                  //                                                   .elementAt(
                  //                                                       index)
                  //                                                   .precioXl!)
                  //                                               .toString() +
                  //                                           '  Bs.',
                  //                                       style: TextStyle(
                  //                                           fontSize: 20.0,
                  //                                           color:
                  //                                               Colors.white),
                  //                                     ),
                  //                           title: Text(
                  //                             _con.serviciosLavadosExtrasPro
                  //                                 .elementAt(index)
                  //                                 .nombre!,
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                           subtitle: Text(
                  //                             _con.serviciosLavadosExtrasPro
                  //                                 .elementAt(index)
                  //                                 .detalle!,
                  //                             style: TextStyle(
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                           value: this
                  //                               ._con
                  //                               .serviciosLavadosExtrasPro
                  //                               .elementAt(index)
                  //                               .esSeleccionado,
                  //                           onChanged: (bool? elegido) {
                  //                             setState(() {
                  //                               this
                  //                                   ._con
                  //                                   .serviciosLavadosExtrasPro
                  //                                   .elementAt(index)
                  //                                   .esSeleccionado = elegido;
                  //                               _con.insertaServElegidosAdicional(
                  //                                   _con.serviciosLavadosExtrasPro
                  //                                       .elementAt(index));
                  //                             });
                  //                           },
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  // Divider(
                  //   color: Colors.grey,
                  // ),
                  widget.tipoServicio == 'P'
                      ? Container()
                      : Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: ExpansionTile(
                            title: Text(
                              'SERVICIOS EXTRAS',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Seleccione uno o varios servicios extras',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30.0,
                              child: Text(
                                'SE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              ),
                              backgroundColor: Colors.grey,
                            ),
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _con.serviciosExtrasPro.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          CheckboxListTile(
                                            secondary: _con.vehiculoElegido
                                                        .tamanio ==
                                                    'M'
                                                ? Text(
                                                    double.parse(_con
                                                                .serviciosExtrasPro
                                                                .elementAt(
                                                                    index)
                                                                .precioM!)
                                                            .toString() +
                                                        '  Bs.',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white),
                                                  )
                                                : _con.vehiculoElegido
                                                            .tamanio ==
                                                        'L'
                                                    ? Text(
                                                        double.parse(_con
                                                                    .serviciosExtrasPro
                                                                    .elementAt(
                                                                        index)
                                                                    .precioL!)
                                                                .toString() +
                                                            '  Bs.',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        double.parse(_con
                                                                    .serviciosExtrasPro
                                                                    .elementAt(
                                                                        index)
                                                                    .precioXl!)
                                                                .toString() +
                                                            '  Bs.',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                            title: Text(
                                              _con.serviciosExtrasPro
                                                  .elementAt(index)
                                                  .nombre!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0),
                                            ),
                                            subtitle: Text(
                                              _con.serviciosExtrasPro
                                                  .elementAt(index)
                                                  .detalle!,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            value: this
                                                ._con
                                                .serviciosExtrasPro
                                                .elementAt(index)
                                                .esSeleccionado,
                                            onChanged: (bool? elegido) {
                                              setState(() {
                                                this
                                                    ._con
                                                    .serviciosExtrasPro
                                                    .elementAt(index)
                                                    .esSeleccionado = elegido;
                                                _con.insertaServElegidosAdicional(
                                                    _con.serviciosExtrasPro
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
                                        valueChanged: null,
                                        tipoServicio: widget.tipoServicio,
                                      );
                                    },
                                    fullscreenDialog: true),
                              );
                            },
                            color: widget.tipoServicio == 'N'
                                ? Colors.grey[500]
                                : Theme.of(context).primaryColor,
                            textColor: widget.tipoServicio == 'N'
                                ? Colors.black
                                : Theme.of(context).hintColor,
                            icon: Image.asset(
                              'assets/img/cuando_off.png',
                              width: 50,
                              color: widget.tipoServicio == 'N'
                                  ? Colors.black
                                  : Theme.of(context).hintColor,
                            ),
                            label: Text('Elegir la Fecha y Hora'),
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
                      color: widget.tipoServicio == 'N'
                          ? Colors.grey[500]
                          : Theme.of(context).primaryColor,
                      textColor: widget.tipoServicio == 'N'
                          ? Colors.black
                          : Theme.of(context).hintColor,
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
    );
  }
}
