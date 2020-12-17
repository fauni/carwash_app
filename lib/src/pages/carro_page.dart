//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ListTile(
              leading: Icon(Icons.directions_bus,
                  color: Theme.of(context).hintColor),
              title: Text('Elige tu vehiculo'),
              subtitle: Text('Presiona el el Item para Elegir el Vehiculo'),
            ),
          ),
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
                      onTap: (){
                        //print(index.toString() );
                        _con.eligeVehiculo(_con.vehiculos.elementAt(index));
                        //print(_con.vehiculoElegido.placa );
                      },
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 1.0),
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
                print('Agregar nuevo carro -------');
              },
            ),
          ),
        ],
      ),
    );
    // return SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Text('Hora: ' + _con.servicio,
    //           style: TextStyle(color: Theme.of(context).accentColor)),
    //       Padding(
    //         padding: EdgeInsets.only(top: 10, left: 20, right: 20),
    //         child: ListTile(
    //           leading: Icon(Icons.directions_bus,
    //               color: Theme.of(context).hintColor),
    //           title: Text('Elige tu vehiculo'),
    //           subtitle: Text('Long press to edit item swipe'),
    //         ),
    //       ),
    //       _con.carros.isEmpty
    //           ? CircularLoadingWidget(height: 50)
    //           : ListView.separated(
    //               padding: EdgeInsets.symmetric(vertical: 15),
    //               shrinkWrap: true,
    //               primary: false,
    //               scrollDirection: Axis.vertical,
    //               itemBuilder: (context, index) {
    //                 return ListTile(
    //                   leading:
    //                       Icon(Icons.map, color: Theme.of(context).hintColor),
    //                   title: Text(_con.carros.elementAt(index).id.toString() +
    //                       ', Placa :' +
    //                       _con.carros.elementAt(index).placa),
    //                   subtitle:
    //                       Text(_con.carros.elementAt(index).observaciones),
    //                   trailing: Checkbox(
    //                     value: selected,
    //                     onChanged: (bool val) {
    //                       setState(() {
    //                         selected = val;
    //                       });
    //                     },
    //                   ),
    //                 );
    //               },
    //               separatorBuilder: (context, index) {
    //                 return SizedBox(
    //                   height: 15,
    //                 );
    //               },
    //               itemCount: _con.carros.length,
    //             )
    //     ],
    //   ),
    // );
  }
}
