//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/pages/fecha_page.dart';
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
    tipoAuto = _con.vehiculoElegido.tamanio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona los Servicios'),
        backgroundColor: Colors.transparent,
        actions: [
          _con.serviciosElegidos.length > 0
              ? IconButton(
                  color: Theme.of(context).hintColor,
                  icon: Icon(Icons.check),
                  onPressed: () => Navigator.of(context).pop())
              : Text('')
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return new FechaPage(switchValue: null, valueChanged: null);
                },
                fullscreenDialog: true),
          );
        },
        label: Text(
          _con.total.toString() + 'Bs.',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100),
        ),
        icon: Icon(Icons.navigate_next),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 40,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(color: Theme.of(context).accentColor)),
                //   margin: EdgeInsets.all(0),
                //   child: Center(
                //     child: Text(
                //       'Seleccione los Servicios',
                //       style: TextStyle(color: Theme.of(context).hintColor),
                //     ),
                //   ),
                // ),
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
                          side:
                              BorderSide(color: Theme.of(context).accentColor)),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CheckboxListTile(
                              secondary: _con.vehiculoElegido.tamanio == 'M'
                                  ? Text(
                                      double.parse(_con.serviciosGeneral
                                                  .elementAt(index)
                                                  .precioM)
                                              .toString() +
                                          '  Bs.',
                                      style: TextStyle(fontSize: 20.0),
                                    )
                                  : _con.vehiculoElegido.tamanio == 'L'
                                      ? Text(
                                          double.parse(_con.serviciosGeneral
                                                      .elementAt(index)
                                                      .precioL)
                                                  .toString() +
                                              '  Bs.',
                                          style: TextStyle(fontSize: 20.0),
                                        )
                                      : Text(
                                          double.parse(_con.serviciosGeneral
                                                      .elementAt(index)
                                                      .precioXl)
                                                  .toString() +
                                              '  Bs.',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                              title:
                                  Text(_con.servicios.elementAt(index).nombre),
                              subtitle:
                                  Text(_con.servicios.elementAt(index).detalle),
                              value: this
                                  ._con
                                  .servicios
                                  .elementAt(index)
                                  .esSeleccionado,
                              onChanged: (bool elegido) {
                                setState(() {
                                  this
                                      ._con
                                      .servicios
                                      .elementAt(index)
                                      .esSeleccionado = elegido;
                                  _con.insertaServElegidos(
                                      _con.serviciosGeneral.elementAt(index));
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   width: double.infinity,
                //   height: 60.0,
                //   padding: EdgeInsets.all(20),
                //   margin: EdgeInsets.only(bottom: 20),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Theme.of(context).primaryColor),
                //   child: Text(
                //     'Total del Servicio: ' + _con.total.toString() + 'Bs.',
                //     style: TextStyle(fontSize: 15.0),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
