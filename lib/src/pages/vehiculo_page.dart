//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../widgets/CircularLoadingWidget.dart';
import 'agregar_vehiculo_page.dart';

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
  double width_size;
  double height_size;
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
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Mis Vehiculos'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/img/fondo_car.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/img/isotipo.png',
                width: MediaQuery.of(context).size.width / 6,
              ),
            ),
          ),
          _con.vehiculos.isEmpty
              ? Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 200),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/auto_on.png',
                        width: 100,
                      ),
                      Text(
                        'No tiene vehiculos registrados',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.transparent.withOpacity(0.1),
                  width: width_size,
                  height: height_size,
                  padding: EdgeInsets.only(top: 160),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.transparent.withOpacity(0.1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: _con.RutaImg(
                                    _con.vehiculos.elementAt(index).foto),
                                /************* */
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        )),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              title: Text(
                                  _con.vehiculos.elementAt(index).placa +
                                      ' - ' +
                                      _con.vehiculos.elementAt(index).marca),
                              subtitle: Text(
                                _con.vehiculos.elementAt(index).modelo +
                                    ' ' +
                                    _con.vehiculos.elementAt(index).anio +
                                    ' - ' +
                                    _con.vehiculos.elementAt(index).tamanio,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                // TextButton(
                                //   child: const Text('Editar'),
                                //   onPressed: () {/* ... */},
                                // ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Eliminar'),
                                  onPressed: () {
                                    _con.showAlertDialog(context,
                                        _con.vehiculos.elementAt(index).id);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                      // return ListTile(
                      //   leading: CachedNetworkImage(
                      //     imageUrl: _con.RutaImg(
                      //         _con.vehiculos.elementAt(index).foto),
                      //     /************* */
                      //     imageBuilder: (context, imageProvider) => Container(
                      //         width: 80.0,
                      //         height: 80.0,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           image: DecorationImage(
                      //               image: imageProvider, fit: BoxFit.cover),
                      //         )),
                      //     placeholder: (context, url) =>
                      //         CircularProgressIndicator(),
                      //     errorWidget: (context, url, error) =>
                      //         Icon(Icons.error),
                      //   ),
                      //   title: Text(_con.vehiculos.elementAt(index).placa +
                      //       ' - ' +
                      //       _con.vehiculos.elementAt(index).marca),
                      //   subtitle: Text(
                      //     _con.vehiculos.elementAt(index).modelo +
                      //         ' ' +
                      //         _con.vehiculos.elementAt(index).anio +
                      //         ' - ' +
                      //         _con.vehiculos.elementAt(index).tamanio,
                      //   ),
                      // );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 0,
                      );
                    },
                    itemCount: _con.vehiculos.length,
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                title: Text('Agregar un Vehiculo'),
                subtitle: Text('Nuevo Vehiculo'),
                onTap: () {
                  _abrirNuevoVehiculo();
                  Navigator.of(context).pushNamed('/AddVehiculo');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _abrirNuevoVehiculo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarVehiculoPage(
          onDismissed: () {
            print('Cerrar siiiiiiiiiiiiiiiiiii');
          },
        ),
      ),
    );

    if (result != null) {
      if (result) {
        _con.listarCarrosByCliente();
        // widget.onDismissed.call();
      }
    }
  }
}
