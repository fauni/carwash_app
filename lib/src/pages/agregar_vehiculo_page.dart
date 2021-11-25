import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:group_button/group_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/widgets/circular_loading_widget.dart';

class AgregarVehiculoPage extends StatefulWidget {
  VoidCallback? onDismissed;

  AgregarVehiculoPage({this.onDismissed});
  @override
  AgregarVehiculoPageState createState() => AgregarVehiculoPageState();
}

class AgregarVehiculoPageState extends StateMVC<AgregarVehiculoPage> {
  Vehiculo vehiculoNuevo = new Vehiculo();
  late CarroController _con;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  AgregarVehiculoPageState() : super(CarroController()) {
    _con = controller as CarroController;
    vehiculoNuevo.idTipo = "1";
  }

  @override
  void initState() {
    _con.listarModelosVehiculo();
    _con.listarTipoVehiculo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // vehiculoNuevo.idTipo = "1";
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Agregar Nuevo Vehiculo'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          // actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/img/fondo_car.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Theme.of(context).accentColor),
                      ),

                      height: 150, //MediaQuery.of(context).size.height / 3,
                      child: Center(
                          child: _con.image == null
                              ? FloatingActionButton(
                                  onPressed: () {
                                    _con.getImage(2);
                                  },
                                  child: Icon(Icons.camera_alt),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                )
                              : Image(
                                  image: FileImage(_con.image!),
                                )),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton.icon(
                            icon: Icon(Icons.camera_rounded),
                            label: Text('Buscar Imagen'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).hintColor,
                            onPressed: () {
                              _con.getImage(1);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          RaisedButton.icon(
                            icon: Icon(Icons.camera_alt),
                            label: Text('Capturar Imagen'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).hintColor,
                            onPressed: () {
                              _con.getImage(2);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    RaisedButton.icon(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).hintColor,
                      label: Text('Nuevo Modelo de Vehículo'),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialogGuardarModeloVehiculo();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<VehiculoModelo>(
                      mode: Mode.DIALOG,
                      maxHeight: 300,
                      items: _con.modelos,
                      label: "Seleccionar Modelo de Vehiculo",
                      itemAsString: (VehiculoModelo mod) =>
                          mod.marca! + ' ' + mod.modelo! + ' ' + mod.anio!,
                      onChanged: (modelo) {
                        //print (modelo.modelo);
                        vehiculoNuevo.idModelo = modelo!.id;
                        vehiculoNuevo.anio = modelo.anio;
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
                              color: Theme.of(context).accentColor, width: 1.0),
                        ),
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                    Divider(),
                    Text('Elija el tamaño de su vehículo'),
                    Divider(),
                    GroupButton(
                      isRadio: true,
                      spacing: 10,
                      buttons: ['M', 'L', 'XL'],
                      onSelected: (index, isSelected) {
                        _con.informacionConfirmacion(context);
                        print('$index fue seleccionado');
                        if (index == 0) {
                          vehiculoNuevo.idTipo = "1";
                        } else if (index == 1) {
                          vehiculoNuevo.idTipo = "3";
                        } else {
                          vehiculoNuevo.idTipo = "5";
                        }
                      },
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedTextStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                      unselectedColor: Colors.transparent,
                      unselectedBorderColor: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                    TextField(
                      onChanged: (cadena) {
                        print(cadena);
                        vehiculoNuevo.placa = cadena;
                      },
                      decoration: InputDecoration(
                          hintText: 'Ingrese su Nro. de Placa',
                          hintStyle:
                              TextStyle(color: Theme.of(context).hintColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor)),
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
                      unselectedBorderColor: Theme.of(context).accentColor,
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
                          vehiculoNuevo.idCliente =
                              "1"; //provisional cambiar por cliente actual
                          vehiculoNuevo.observaciones = "";
                          vehiculoNuevo.estado = "A";
                          //vehiculoNuevo.anio = "1900";
                          vehiculoNuevo.foto = "ff";
                          _con.registrarVehiculo(context, vehiculoNuevo);
                        },
                        child: Text('Guardar Datos de su Vehiculo'),
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

  void showDialogGuardarModeloVehiculo() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Modelo de Vehículo"),
              content: Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Agregar Modelo de Vehiculo'),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<String>(
                        mode: Mode.DIALOG,
                        maxHeight: 350,
                        items: _con.anios,
                        label: "Seleccionar el Año",
                        itemAsString: (String mod) => mod,
                        onChanged: (modelo) {
                          //print (modelo.modelo);
                          _con.vehiculomodelo.anio = modelo;
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
                          labelText: "Buscar Año del Vehiculo",
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
                              'Año del Vehiculo',
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
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<String>(
                        mode: Mode.DIALOG,
                        maxHeight: 350,
                        items: _con.marcas,
                        label: "Seleccionar el Fabricante",
                        itemAsString: (String mod) => mod,
                        onChanged: (modelo) {
                          //print (modelo.modelo);
                          _con.vehiculomodelo.marca = modelo;
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
                          labelText: "Buscar Fabricantes de Vehiculo",
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
                              'Fabricantes de Vehiculo',
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (cadena) {
                          _con.vehiculomodelo.modelo = cadena;
                        },
                        decoration: InputDecoration(
                            hintText: 'Ingrese el Modelo',
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0),
                            ),
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Theme.of(context).accentColor)),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    if (_con.vehiculomodelo.anio == null ||
                        _con.vehiculomodelo.marca == null ||
                        _con.vehiculomodelo.modelo == null) {
                      scaffoldKey.currentState!.showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Completa la información, antes de guardar'),
                          action: SnackBarAction(
                              label: "Aceptar", onPressed: () {}),
                        ),
                      );
                    } else {
                      _con.registrarModeloVehiculo(context);
                    }
                  },
                ),
                OutlinedButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
