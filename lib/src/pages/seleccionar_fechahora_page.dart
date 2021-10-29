import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/pages/confirmar_reserva_page.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeleccionarFechahoraPage extends StatefulWidget {
  String? tipoServicio;
  SeleccionarFechahoraPage(
      {@required this.switchValue,
      @required this.valueChanged,
      this.tipoServicio});

  final bool? switchValue;
  final ValueChanged? valueChanged;

  @override
  State<StatefulWidget> createState() {
    return SeleccionarFechahoraPageState();
  }
}

class SeleccionarFechahoraPageState extends StateMVC<SeleccionarFechahoraPage> {
  bool selected = false;
  late ReservaController _con;
  Reserva reserva = new Reserva();

  bool? _switchValue;
  final format = DateFormat("yyyy-MM-dd");

  SeleccionarFechahoraPageState() : super(ReservaController()) {
    _con = controller as ReservaController;
    reserva.fechaReserva = _con.obtieneFechaActual();
  }

  @override
  void initState() {
    _switchValue = widget.switchValue!;
    _con.verificaInformacion(context);

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
      body: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: Stack(
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
                      border: Border.all(
                        color: widget.tipoServicio == 'N'
                            ? Colors.white
                            : Theme.of(context).accentColor,
                      ),
                    ),
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
                    selectionColor: widget.tipoServicio == 'N'
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    selectedTextColor: widget.tipoServicio == 'N'
                        ? Colors.black
                        : Theme.of(context).hintColor,
                    deactivatedColor: Theme.of(context).primaryColor,
                    monthTextStyle:
                        TextStyle(color: Theme.of(context).hintColor),
                    dateTextStyle:
                        TextStyle(color: Theme.of(context).hintColor),
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
                      border: Border.all(
                        color: widget.tipoServicio == 'N'
                            ? Colors.white
                            : Theme.of(context).accentColor,
                      ),
                    ),
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
                                selected: item.esSeleccionado!,
                                label: Text(item.hora!.substring(0, 5)),
                                labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor),
                                backgroundColor: Colors
                                    .black, // Theme.of(context).accentColor,
                                selectedColor: widget.tipoServicio == 'N'
                                    ? Colors.grey[500]
                                    : Theme.of(context).primaryColor,
                                onSelected: (bool selected) {
                                  setState(() {
                                    item.esSeleccionado = !item.esSeleccionado!;
                                    _con.hora = item;
                                    if (selected) {
                                      _con.deseleccionarHoras();
                                      reserva.horaReserva = _con.hora.hora!;
                                      _con.eligeReserva(reserva);
                                    }
                                  });
                                },
                              ),
                          ]),
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
      ),
    );
  }
}
