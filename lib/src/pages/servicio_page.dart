//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/servicio_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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

  String tipoAuto = 'L';
  ServicioController _con;

  // bool _switchValue;

  ServicioPageState() : super(ServicioController()) {
    _con = controller;
  }
  @override
  void initState() {
    // _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).accentColor)),
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'SELECCIONE LOS SERVICIOS',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          ),
          SizedBox(
            height: 130,
            child: GridView.builder(
              itemCount: _con.serviciosGeneral.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 2.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // print(_con.serviciosGeneral.elementAt(index).nombre);
                    Navigator.of(context).pushNamed('/Servicio',
                        arguments: new RouteArgument(
                            id: _con.serviciosGeneral.elementAt(index).id,
                            param: [_con.servicios.elementAt(index), '']));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(_con.serviciosGeneral.elementAt(index).nombre),
                        if (this.tipoAuto == 'M')
                          Text(
                            double.parse(_con.serviciosGeneral
                                        .elementAt(index)
                                        .precioM)
                                    .toString() +
                                '.Bs',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        if (this.tipoAuto == 'L')
                          Text(
                            double.parse(_con.serviciosGeneral
                                        .elementAt(index)
                                        .precioL)
                                    .toString() +
                                '.Bs',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        if (this.tipoAuto == 'XL')
                          Text(
                            double.parse(_con.serviciosGeneral
                                        .elementAt(index)
                                        .precioXl)
                                    .toString() +
                                '.Bs',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        // Text(
                        //   _con.serviciosGeneral.elementAt(index).detalle,
                        //   style: TextStyle(fontSize: 10.0),
                        // )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).accentColor)),
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'SERVICIOS ADICIONALES',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              itemCount: _con.serviciosAdicionales.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Text(_con.serviciosAdicionales.elementAt(index).nombre),
                      if (this.tipoAuto == 'M')
                        Text(
                          double.parse(_con.serviciosAdicionales
                                      .elementAt(index)
                                      .precioM)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      if (this.tipoAuto == 'L')
                        Text(
                          double.parse(_con.serviciosAdicionales
                                      .elementAt(index)
                                      .precioL)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      if (this.tipoAuto == 'XL')
                        Text(
                          double.parse(_con.serviciosAdicionales
                                      .elementAt(index)
                                      .precioXl)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      // Text(
                      //   _con.serviciosGeneral.elementAt(index).detalle,
                      //   style: TextStyle(fontSize: 10.0),
                      // )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).accentColor)),
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'SERVICIOS PARA MOTOS',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: GridView.builder(
              itemCount: _con.serviciosMotos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 2.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Text(_con.serviciosMotos.elementAt(index).nombre),
                      if (this.tipoAuto == 'M')
                        Text(
                          double.parse(_con.serviciosMotos
                                      .elementAt(index)
                                      .precioM)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      if (this.tipoAuto == 'L')
                        Text(
                          double.parse(_con.serviciosMotos
                                      .elementAt(index)
                                      .precioL)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      if (this.tipoAuto == 'XL')
                        Text(
                          double.parse(_con.serviciosMotos
                                      .elementAt(index)
                                      .precioXl)
                                  .toString() +
                              '.Bs',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      // Text(
                      //   _con.serviciosGeneral.elementAt(index).detalle,
                      //   style: TextStyle(fontSize: 10.0),
                      // )
                    ],
                  ),
                );
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
    //       Padding(
    //         padding: EdgeInsets.only(top: 10, left: 20, right: 20),
    //         child: ListTile(
    //           leading: Icon(Icons.map, color: Theme.of(context).hintColor),
    //           title: Text('Servicio Plus'),
    //           subtitle: Text('Long press to edit item swipe'),
    //         ),
    //       ),
    //       _con.servicios.isEmpty
    //           ? CircularLoadingWidget(height: 50)
    //           : ListView.separated(
    //               padding: EdgeInsets.symmetric(vertical: 15),
    //               shrinkWrap: true,
    //               primary: false,
    //               scrollDirection: Axis.vertical,
    //               itemBuilder: (context, index) {
    //                 return ListTile(

    //                   title: Text(
    //                     _con.servicios.elementAt(index).nombre +
    //                         '\nM:' +
    //                         double.parse(
    //                                 _con.servicios.elementAt(index).precioM)
    //                             .toString() +
    //                         ' Bs.' +
    //                         '   L:' +
    //                         double.parse(
    //                                 _con.servicios.elementAt(index).precioL)
    //                             .toString() +
    //                         ' Bs.' +
    //                         '   XL:' +
    //                         double.parse(
    //                                 _con.servicios.elementAt(index).precioXl)
    //                             .toString(),
    //                   ),
    //                   subtitle: Text(_con.servicios.elementAt(index).detalle),
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
    //               itemCount: _con.servicios.length,
    //             )
    //     ],
    //   ),
    // );
  }
}
