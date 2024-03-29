import 'package:flutter/material.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:carwash/src/models/tipo_vehiculo.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:group_button/group_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'circular_loading_widget.dart';

class AddVehiculoWidget extends StatefulWidget {
  @override
  AddVehiculoWidgetState createState() => AddVehiculoWidgetState();
}

class AddVehiculoWidgetState extends StateMVC<AddVehiculoWidget> {
  Vehiculo? vehiculoNuevo = new Vehiculo();
  late CarroController _con;

  AddVehiculoWidgetState() : super(CarroController()) {
    _con = controller as CarroController;
  }

  @override
  void initState() {
    _con.listarModelosVehiculo();
    _con.listarTipoVehiculo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('Agregar Nuevo Vehiculo'),
          leading: IconButton(
            icon: Icon(Icons.clear, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: !_con.loading
            ? Stack(
                children: [
                  Image.asset(
                    'assets/img/fondo_car.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              child: _con.image == null
                                  ? FloatingActionButton(
                                      onPressed: () {
                                        _con.getImage(1);
                                      },
                                      child: Icon(Icons.camera_alt),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    )
                                  : Image(
                                      image: FileImage(_con.image!),
                                    ),
                            ),
                          ),
                          Divider(),
                          DropdownSearch<VehiculoModelo>(
                            mode: Mode.BOTTOM_SHEET,
                            maxHeight: 300,
                            items: _con.modelos,
                            label: "Seleccionar Modelo de Automovil",
                            itemAsString: (VehiculoModelo mod) =>
                                mod.marca! +
                                ' ' +
                                mod.modelo! +
                                ' ' +
                                mod.anio!,
                            onChanged: (modelo) {
                              //print (modelo.modelo);
                              vehiculoNuevo!.idModelo = modelo!.id;
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
                              labelStyle:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                            searchBoxDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Buscar Modelo de Automovil",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Modelo de Automovil',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          Divider(),
                          DropdownSearch<TipoVehiculo>(
                            mode: Mode.BOTTOM_SHEET,
                            maxHeight: 300,
                            items: _con.tipos,
                            label: "Seleccionar Tipo de Automovil",
                            itemAsString: (TipoVehiculo data) =>
                                data.tipo! + ' ' + data.tamanio!,
                            onChanged: (tipo) {
                              vehiculoNuevo!.idTipo = tipo!.id;
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
                              labelStyle:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                            searchBoxDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Buscar Tipo de Vehiculo",
                            ),
                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  'Tipo de Vehiculo',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          Divider(),
                          TextField(
                            onChanged: (cadena) {
                              print(cadena);
                              vehiculoNuevo!.placa = cadena;
                            },
                            decoration: InputDecoration(
                                hintText: 'Ingrese su Nro. de Placa',
                                hintStyle: TextStyle(
                                    color: Theme.of(context).hintColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 1.0),
                                ),
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    color: Theme.of(context).accentColor)),
                          ),
                          Divider(),
                          GroupButton(
                            isRadio: true,
                            spacing: 10,
                            buttons: ['Auto', 'Moto', 'UTV'],
                            onSelected: (index, isSelected) {
                              print('$index fue seleccionado');
                              if (index == 0) {
                              } else if (index == 1) {
                              } else {}
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
                          ButtonTheme(
                            minWidth: double.infinity,
                            height: 50.0,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).hintColor,
                              onPressed: () {
                                vehiculoNuevo!.idCliente =
                                    "1"; //provisional cambiar por cliente actual
                                vehiculoNuevo!.observaciones = "";
                                vehiculoNuevo!.estado = "A";
                                vehiculoNuevo!.anio = "1900";
                                vehiculoNuevo!.foto = "ff";
                                print('guardando el auto');
                                _con.registrarVehiculo(context, vehiculoNuevo!);
                              },
                              child: Text('Guardar Movilidad'),
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
              )
            : CircularLoadingWidget(
                height: MediaQuery.of(context).size.height,
              ));
  }
}
