import 'package:flutter/material.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:carwash/src/models/tipo_vehiculo.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:carwash/src/models/vehiculo.dart';

class AddVehiculoWidget extends StatefulWidget {
  @override
  AddVehiculoWidgetState createState() => AddVehiculoWidgetState();
}

class AddVehiculoWidgetState extends StateMVC<AddVehiculoWidget> {
  Vehiculo vehiculoNuevo = new Vehiculo();
  CarroController _con;

  AddVehiculoWidgetState() : super(CarroController()) {
    _con = controller;
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Agregar un auto nuevo'),
        leading: new IconButton(
          icon: new Icon(Icons.clear, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).accentColor)),

                height: 150, //MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.camera_alt),
                    backgroundColor: Theme.of(context).primaryColor,
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
                    mod.marca + ' ' + mod.modelo + ' ' + mod.anio,
                onChanged: (modelo){
                  //print (modelo.modelo);
                  vehiculoNuevo.idModelo= modelo.id;
                },
                selectedItem: null,
                showSearchBox: true,
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 0.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 1.0),
                  ),
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                ),
                searchBoxDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Buscar Modelo de Automovil",
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
                      'Modelo de Automovil',
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
              Divider(),
              DropdownSearch<TipoVehiculo>(
                mode: Mode.BOTTOM_SHEET,
                maxHeight: 300,
                items: _con.tipos,
                label: "Seleccionar Tipo de Automovil",
                itemAsString: (TipoVehiculo data) =>
                    data.tipo + ' ' + data.tamanio,
                onChanged: (tipo){
                    print(tipo.tipo);
                    vehiculoNuevo.idTipo = tipo.id; 
                },
                selectedItem: null,
                showSearchBox: true,
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 0.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 1.0),
                  ),
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                ),
                searchBoxDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Buscar Tipo de Vehiculo",
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
                      'Tipo de Vehiculo',
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
              Divider(),
              TextField(
                onChanged: (cadena){
                  print(cadena);
                  vehiculoNuevo.placa = cadena;
                },
                decoration: InputDecoration(
                    hintText: 'Ingrese su Nro. de Placa',
                    hintStyle: TextStyle(color: Theme.of(context).accentColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 1.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(color: Theme.of(context).accentColor)),
                    
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Radio(
                    value: 0,
                    groupValue: 'Auto',
                    onChanged: (value){
                      print(value);
                    },
                  ),
                  new Text(
                    'Auto',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: 'Moto',
                    onChanged: (value){
                      print(value);
                    },
                  ),
                  new Text(
                    'Moto',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: 'UTV',
                    onChanged: (value){
                      print(value);
                    },
                  ),
                  new Text(
                    'UTV',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Divider(),
              ButtonTheme(
                minWidth: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).hintColor,
                  onPressed: () {
                    vehiculoNuevo.idCliente = "1"; //provisional cambiar por cliente actual
                    vehiculoNuevo.observaciones="";
                    vehiculoNuevo.estado="A";
                    vehiculoNuevo.anio="1900";
                    vehiculoNuevo.foto="ff";
                    print('guardando el auto');
                    _con.registrarVehiculo(vehiculoNuevo);
                  },
                  child: Text('Guardar Movilidad'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
