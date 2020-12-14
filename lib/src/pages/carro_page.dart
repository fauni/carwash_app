//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../widgets/CircularLoadingWidget.dart';

class CarroPage extends StatefulWidget {
  CarroPage({@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return CarroPageState();
  }
}

class CarroPageState extends StateMVC<CarroPage> {
  bool selected = false;
  CarroController _con;

  bool _switchValue;

  CarroPageState() : super(CarroController()) {
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
              leading: Icon(Icons.directions_bus, color: Theme.of(context).hintColor),
              title: Text('Elige tu vehiculo'),
              subtitle: Text('Long press to edit item swipe'),
            ),
          ),
          _con.carros.isEmpty
              ? CircularLoadingWidget(height: 50)
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.map, color: Theme.of(context).hintColor),
                      title: Text(
                        _con.carros.elementAt(index).id.toString()+', Placa :'+_con.carros.elementAt(index).placa 
                      ),
                      subtitle: Text(_con.carros.elementAt(index).observaciones),
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
                  itemCount: _con.carros.length,
                )
        ],
      ),
    );
  }
}
