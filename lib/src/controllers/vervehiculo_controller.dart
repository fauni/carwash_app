import 'dart:convert';

//import 'package:carwash/src/generated/i18n.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/vehiculomodelo_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class VerVehiculoController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  bool loading=false;
  bool loadingV=false;
  VehiculoA vehiculo = VehiculoA();
  List<VehiculoModelo> modelos = new List<VehiculoModelo>();
  VerVehiculoController() {
    
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  // Obtener modelos de vehiculos
  void listarModelosVehiculo({String message}) async {
    loading = true;
    final Stream<List<VehiculoModelo>> stream = await obtenerModelosVehiculo();
    stream.listen((List<VehiculoModelo> _modelos) {
      setState(() {
        modelos = _modelos;
        // print("===============================");
        // print(jsonEncode(modelos));
        // print(jsonEncode(carros));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("error al guardas"),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
      loading=false;
      setState(() { });
    });
  }
  

  //registrar modificacion en el servidor
  void guardaEdicionVehiculo() async {
    
      this.loading = true;
      this.loadingV = true;
      setState(() {
        //image = null;
      });
      var vehiculoResp = await modificarVehiculo(this.vehiculo) ;
      
      this.loading = false;

      this.scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Se modifico correctamente'),
            backgroundColor: Theme.of(context).primaryColor ,
          ));
      setState(() {});
      await Future.delayed(const Duration(seconds: 1));
      //print('____ANTES DE ENVIAR___');
      //print(newVehiculo.imgFile);
    
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/Vehiculos', arguments: 3);
  }


}