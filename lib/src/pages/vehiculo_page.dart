//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
                  Navigator.of(context).pushNamed('/AddVehiculo');
                  // showDialog<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return Dialog(
                  //       child: Container(
                  //         child: Column(children: [
                  //           Text(
                  //             'Agregar un auto nuevo',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 15),
                  //           ),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(10),
                  //                 border: Border.all(
                  //                     color: Theme.of(context).accentColor)),

                  //             height:
                  //                 150, //MediaQuery.of(context).size.height / 3,
                  //             child: Center(
                  //               child: FloatingActionButton(
                  //                 onPressed: () {},
                  //                 child: Icon(Icons.camera_alt),
                  //                 backgroundColor:
                  //                     Theme.of(context).primaryColor,
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 15,
                  //           ),
                  //           DropdownSearch<String>(
                  //             mode: Mode.BOTTOM_SHEET,
                  //             maxHeight: 300,
                  //             items: ["Brazil", "Italia", "Tunisia", 'Canada'],
                  //             label: "Custom BottomShet mode",
                  //             onChanged: print,
                  //             selectedItem: "Brazil",
                  //             showSearchBox: true,
                  //             searchBoxDecoration: InputDecoration(
                  //               border: OutlineInputBorder(),
                  //               contentPadding:
                  //                   EdgeInsets.fromLTRB(12, 12, 8, 0),
                  //               labelText: "Search a country",
                  //             ),
                  //             popupTitle: Container(
                  //               height: 50,
                  //               decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColorDark,
                  //                 borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(20),
                  //                   topRight: Radius.circular(20),
                  //                 ),
                  //               ),
                  //               child: Center(
                  //                 child: Text(
                  //                   'Country',
                  //                   style: TextStyle(
                  //                     fontSize: 24,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             popupShape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(24),
                  //                 topRight: Radius.circular(24),
                  //               ),
                  //             ),
                  //           ),
                  //         ]),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
