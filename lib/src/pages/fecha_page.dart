//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/fecha_controller.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FechaPage extends StatefulWidget {
  FechaPage({@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return FechaPageState();
  }
}

class FechaPageState extends StateMVC<FechaPage> {
  bool selected = false;
  ReservaController _con;
  Reserva reserva = new Reserva();

  bool _switchValue;
  final format = DateFormat("yyyy-MM-dd");

  FechaPageState() : super(ReservaController()) {
    _con = controller;
  }
  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).accentColor)),
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'SELECCIONE LA FECHA',
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
            deactivatedColor: Theme.of(context).accentColor,
            monthTextStyle: TextStyle(color: Theme.of(context).hintColor),
            dateTextStyle: TextStyle(color: Theme.of(context).hintColor),
            dayTextStyle: TextStyle(color: Theme.of(context).hintColor),
            locale: "es ES",
            onDateChange: (date) {
              setState(() {
                print(date);
                reserva.fechaReserva = date.toString();
                _con.eligeReserva(reserva);
              });
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).accentColor)),
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'SELECCIONE LA HORA',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          ),
          TimePickerSpinner(
            is24HourMode: true,
            normalTextStyle: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 20,
            ),
            highlightedTextStyle: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 30,
            ),
            time: DateTime.now(),
            minutesInterval: 30,
            spacing: 50,
            itemHeight: 80,
            isForce2Digits: true,
            onTimeChange: (time) {
              setState(() {
                print(time);
                reserva.horaReserva = time.toString();
                _con.eligeReserva(reserva);
                //_con.seleccionarHora(time);
              });
            },
          ),
          ButtonTheme(
            minWidth: double.infinity,
            height: 50.0,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).hintColor,
              onPressed: () {
                _con.setReservaCompleta();
              },
              child: Text('Enviar Reserva'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
