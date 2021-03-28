import 'package:carwash/src/controllers/vervehiculo_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:carwash/src/widgets/CircularLoadingWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:group_button/group_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class VerVehiculoPage extends StatefulWidget {
  RouteArgument routeArgument;
  //AtencionInner atencion;
  String _heroTag;
  VerVehiculoPage({Key key, this.routeArgument}) {
    _heroTag = '1'; //this.routeArgument.param[1] as String;
    // atencion = this.routeArgument.param as AtencionInner;
    // print(this.routeArgument);
  }

  @override
  VerVehiculoPageState createState() => VerVehiculoPageState();
}

class VerVehiculoPageState extends StateMVC<VerVehiculoPage> {
  String url = '${GlobalConfiguration().getString('img_carros_url_wash')}/';
  VerVehiculoController _con;
  double width_size = 0;
  double height_size = 0;

  VerVehiculoPageState() : super(VerVehiculoController()) {
    _con = controller;
    _con.listarModelosVehiculo();
  }

  void initState() {
    super.initState();
    _con.vehiculo = this.widget.routeArgument.param[0];

    url = url + _con.vehiculo.foto;
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;

    print(_con.vehiculo.placa);
    return Scaffold(
        key: _con.scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Datos del Vehículo'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          // actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
        ),
        body: _con.loading
            ? CircularLoadingWidget(height: height_size / 2)
            : Stack(
                children: [
                  Image.asset(
                    'assets/img/fondo_car.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(top: 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),

                            height:
                                150, //MediaQuery.of(context).size.height / 3,
                            child: Center(
                                child: Image(
                              image: NetworkImage(url),
                            )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Placa: ' + _con.vehiculo.placa,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  this._con.vehiculo.marca +
                                      ' - ' +
                                      this._con.vehiculo.modelo,
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Divider(),
                                DropdownSearch<VehiculoModelo>(
                                  mode: Mode.BOTTOM_SHEET,
                                  maxHeight: 300,
                                  items: _con.modelos,
                                  label: "Modificar Modelo de Vehiculo",
                                  itemAsString: (VehiculoModelo mod) =>
                                      mod.marca +
                                      ' ' +
                                      mod.modelo +
                                      ' ' +
                                      mod.anio,
                                  onChanged: (modelo) {
                                    //print (modelo.modelo);
                                    _con.vehiculo.idModelo = modelo.id;
                                    _con.vehiculo.modelo = modelo.modelo;
                                    _con.vehiculo.marca = modelo.marca;
                                    setState(() {});
                                  },
                                  selectedItem: null,
                                  showSearchBox: true,
                                  dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 0.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
                                          width: 1.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  searchBoxDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    labelText: "Buscar Modelo de Vehiculo",
                                  ),
                                  popupTitle: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Modelo de Vehiculo',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Tamaño del vehículo'),
                          Divider(),
                          GroupButton(
                            isRadio: true,
                            spacing: 10,
                            buttons: ['M', 'L', 'XL'],
                            selectedButtons: [_con.vehiculo.tamanio],
                            onSelected: (index, isSelected) {
                              print('$index fue seleccionado');
                              if (index == 0) {
                                _con.vehiculo.idTipo = "1";
                              } else if (index == 1) {
                                _con.vehiculo.idTipo = "3";
                              } else {
                                _con.vehiculo.idTipo = "5";
                              }
                            },
                            selectedColor: Theme.of(context).primaryColor,
                            unselectedTextStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                            unselectedColor: Colors.transparent,
                            unselectedBorderColor:
                                Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/img/m-min.png',
                                width: 100,
                              ),
                              Image.asset(
                                'assets/img/l-min.png',
                                width: 100,
                              ),
                              Image.asset(
                                'assets/img/xl-min.png',
                                width: 100,
                              )
                            ],
                          ),
                          Divider(),
                          _con.loadingV
                              ? Text('')
                              : ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Theme.of(context).hintColor,
                                    onPressed: () {
                                      print('guardando el vehiculo');
                                      _con.guardaEdicionVehiculo();
                                    },
                                    child: Text('Guardar Cambios'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
