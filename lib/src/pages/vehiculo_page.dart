//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../widgets/CircularLoadingWidget.dart';

class VehiculoPage extends StatefulWidget {
  // VehiculoPage({@required this.switchValue, @required this.valueChanged});

  // final bool switchValue;
  // final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return VehiculoPageState();
  }
}

class VehiculoPageState extends StateMVC<VehiculoPage> {
  bool selected = false;
  CarroController _con;

  // bool _switchValue;

  VehiculoPageState() : super(CarroController()) {
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
        title: Text('Mis Autos'),
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
            _con.carros.isEmpty
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
                        leading: CachedNetworkImage(
                          imageUrl: 'http://intranet.lafar.net/images/rav4.jpg',
                          imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              )),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        title: Text(_con.vehiculos.elementAt(index).placa +
                            ' - ' +
                            _con.vehiculos.elementAt(index).marca),
                        subtitle: Text(
                          _con.vehiculos.elementAt(index).modelo +
                              ' ' +
                              _con.vehiculos.elementAt(index).anio +
                              ' - ' +
                              _con.vehiculos.elementAt(index).tamanio,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: _con.vehiculos.length,
                  ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Theme.of(context).accentColor, width: 1.0),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  color: Theme.of(context).hintColor,
                  size: 50,
                ),
                title: Text('Agregar un auto nuevo'),
                subtitle: Text('Nueva Movilidad'),
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                          child: Text('Agregar una Movilidad'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
