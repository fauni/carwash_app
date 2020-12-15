//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/fecha_controller.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
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
  FechaController _con;

  bool _switchValue;
  final format = DateFormat("yyyy-MM-dd");

  FechaPageState() : super(FechaController()) {
    _con = controller;
  }
  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Seleccione la Fecha'),
          DateTimeField(
            onChanged: (value) {
              // _con.carrito.fechaRequerida =
              //     value.toString();
            },
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                builder: (context, child) => Localizations.override(
                  context: context,
                  locale: Locale('es'),
                  child: child,
                ),
                firstDate: DateTime(2020),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2021),
              );
            },
          ),
          DropDown<String>(
            items: <String>["08:00", "08:30", "09:00", "09:30"],
            initialValue: null,
            hint: Text("Seleccione la Hora"),
            onChanged: print,
          ),
        ],
      ),
    );
  }
}
