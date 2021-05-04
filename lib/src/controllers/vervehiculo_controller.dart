import 'dart:convert';
import 'dart:io';


//import 'package:carwash/src/generated/i18n.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/vehiculomodelo_repository.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class VerVehiculoController extends ControllerMVC {

  String url = '${GlobalConfiguration().getString('img_carros_url_wash')}/';
  GlobalKey<ScaffoldState> scaffoldKey;
  bool loading=false;
  bool loadingV=false;
  VehiculoA vehiculo = VehiculoA();
  Vehiculo vehiculoEdit = Vehiculo();
  List<VehiculoModelo> modelos = new List<VehiculoModelo>();
   
   File image;
    final picker = ImagePicker();
  
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

   //registrar modificación de foto en servidor
  void EditarFotoVehiculo(Vehiculo newVehiculo) async {
    if (this.image == null) {
      showAlertDialogError(context, "Necesita agregar una imagen del vehiculo");
    } else {
      String base64Image = base64Encode(this.image.readAsBytesSync());
      String fileName = this.image.path.split("/").last;
      newVehiculo.foto = fileName;
      newVehiculo.imgFile = base64Image;
      newVehiculo.id= this.vehiculo.id;
      newVehiculo.placa= this.vehiculo.placa;
     // newVehiculo.idCliente = currentUser.value.email;

      if (newVehiculo.placa == null) {
        showAlertDialogError(
            context, "Complete la información antes de guardar");
      } else {
        this.loading = true;
        setState(() {
          image = null;
        });

        var vehiculoResp = await modificarFotoVehiculo(newVehiculo);
        this.url = '${GlobalConfiguration().getString('img_carros_url_wash')}/${newVehiculo.foto}';
        this.vehiculo.foto=newVehiculo.foto ;
        this.loading = false;
        this.scaffoldKey?.currentState?.showSnackBar(SnackBar(
              content: Text('Se agregó correctamente'),
            ));
        setState(() {});
        //Navigator.of(context).pop(true);
      }
    }
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
    Navigator.of(context).pushNamed('/Vehiculo', arguments: 3);
  }
    Future getImage(int tipo) async {
    if (tipo == 1) {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxWidth: 300.0, maxHeight: 300.0);
      setState(() {
        image = File(pickedFile.path);  

        EditarFotoVehiculo(this.vehiculoEdit);
        
      });
      
    } else {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);
      setState(() {
        image = File(pickedFile.path);
        EditarFotoVehiculo(this.vehiculoEdit);
      });
    }
  }

  showAlertDialogError(BuildContext context, String mensaje) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Aceptar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No se guardo!"),
      content: Text(mensaje),
      actions: [
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}