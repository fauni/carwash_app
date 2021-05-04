import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/pages/confirmar_reserva_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeleccionarFechahoraPage extends StatefulWidget {
  SeleccionarFechahoraPage(
      {@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return SeleccionarFechahoraPageState();
  }
}

class SeleccionarFechahoraPageState extends StateMVC<SeleccionarFechahoraPage> {
  bool selected = false;
  ReservaController _con;
  Reserva reserva = new Reserva();

  bool _switchValue;
  final format = DateFormat("yyyy-MM-dd");

  SeleccionarFechahoraPageState() : super(ReservaController()) {
    _con = controller;
    reserva.fechaReserva = _con.obtieneFechaActual();
  }

  @override
  void initState() {
    _switchValue = widget.switchValue;
    _con.verificaInformacion();

    _con.listarReservasPorFecha(_con.obtieneFechaActual());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar la fecha y hora'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Selecciona la Fecha',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                DatePicker(
                  DateTime.now(),
                  width: 60,
                  height: 100,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Theme.of(context).primaryColor,
                  selectedTextColor: Theme.of(context).hintColor,
                  deactivatedColor: Theme.of(context).primaryColor,
                  monthTextStyle: TextStyle(color: Theme.of(context).hintColor),
                  dateTextStyle: TextStyle(color: Theme.of(context).hintColor),
                  dayTextStyle: TextStyle(color: Theme.of(context).hintColor),
                  locale: "es ES",
                  onDateChange: (date) {
                    setState(() {
                      print("--------------------date ------------------");
                      print(date);
                      _con.listarReservasPorFecha(date.toString());
                      reserva.fechaReserva = date.toString();
                      _con.eligeReserva(reserva);
                    });
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Selecciona la Hora',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Center(
                    child: Wrap(
                        spacing: 2.0, // gap between adjacent chips
                        runSpacing: 0.0, // gap between lines
                        children: [
                          for (var item in _con.horas)
                            ChoiceChip(
                              selected: item.esSeleccionado,
                              label: Text(item.hora.substring(0, 5)),
                              labelStyle:
                                  TextStyle(color: Theme.of(context).hintColor),
                              backgroundColor: Colors
                                  .black, // Theme.of(context).accentColor,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  item.esSeleccionado = !item.esSeleccionado;
                                  _con.hora = item;
                                  if (selected) {
                                    _con.deseleccionarHoras();
                                    reserva.horaReserva = _con.hora.hora;
                                    _con.eligeReserva(reserva);
                                  }
                                });
                              },
                            ),
                        ]),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: ButtonTheme(
                //     minWidth: double.infinity,
                //     height: 50.0,
                //     child: RaisedButton(
                //       color: Theme.of(context).primaryColor,
                //       textColor: Theme.of(context).hintColor,
                //       onPressed: () {
                //         Navigator.of(context).pop(true);
                //         Navigator.of(context).push(
                //           new MaterialPageRoute(
                //               builder: (BuildContext context) {
                //                 return new ConfirmarReservaPage();
                //               },
                //               fullscreenDialog: true),
                //         );
                //       },
                //       child: Text('Enviar Reserva'),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //     ),
                //   ),
                // )
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
                      label: Text('Finalizar la Reserva'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
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
    );
  }
}
