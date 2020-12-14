import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../widgets/CircularLoadingWidget.dart';

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
  ServicioController _con;

  bool _switchValue;

  ServicioPageState() : super(ServicioController()) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ListTile(
              leading: Icon(Icons.map, color: Theme.of(context).hintColor),
              title: Text('Servicio Plus'),
              subtitle: Text('Long press to edit item swipe'),
            ),
          ),
          _con.servicios.isEmpty
              ? CircularLoadingWidget(height: 50)
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _con.servicios.elementAt(index).nombre +
                            '\nM:' +
                            double.parse(
                                    _con.servicios.elementAt(index).precioM)
                                .toString() +
                            ' Bs.' +
                            '   L:' +
                            double.parse(
                                    _con.servicios.elementAt(index).precioL)
                                .toString() +
                            ' Bs.' +
                            '   XL:' +
                            double.parse(
                                    _con.servicios.elementAt(index).precioXl)
                                .toString(),
                      ),
                      subtitle: Text(_con.servicios.elementAt(index).detalle),
                      trailing: Checkbox(
                        value: selected,
                        onChanged: (bool val) {
                          setState(() {
                            selected = val;
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: _con.servicios.length,
                )
        ],
      ),
    );
  }
}
