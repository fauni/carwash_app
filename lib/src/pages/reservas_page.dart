//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Text('Mis reservas Pendientes'),
        leading: new IconButton(
          icon: new Icon(Icons.clear, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: SingleChildScrollView(
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
                        leading: Icon(Icons.emoji_transportation),
                        title: Text(_con.reservasInner.elementAt(index).fechaReserva +
                            ' ' +
                            _con.reservasInner.elementAt(index).horaReserva),
                        subtitle: Text(
                          _con.reservasInner.elementAt(index).placa +
                              ' - ' +
                               _con.reservasInner.elementAt(index).marca +
                              ', ' +
                              _con.reservasInner.elementAt(index).modelo ,
                        ),
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
    );
  }
}
