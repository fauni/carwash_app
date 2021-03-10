import 'dart:convert';
import 'dart:io';

import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/tipo_vehiculo.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculo_modelo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/repository/modelo_vehiculo_repository.dart';
import 'package:carwash/src/repository/tipo_vehiculo_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
//import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carwash/src/pages/servicio_page.dart';

class CarroController extends ControllerMVC {
  List<Vehiculo> carros = [];
  List<VehiculoA> vehiculos = [];
  List<VehiculoModelo> modelos = [];
  List<TipoVehiculo> tipos = [];

  List<String> anios = [];
  List<String> marcas = [];

  VehiculoA vehiculoElegido;
  VehiculoModelo vehiculomodelo =
      new VehiculoModelo(); // Modelo para crear vehiculo

  String servicio = '';

  File image;
  final picker = ImagePicker();
  bool isCapture = false;
  bool loading = false;

  String dropdownValueAnio = '2020';

  GlobalKey<ScaffoldState> scaffoldKey;

  CarroController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // listarCarrosByIdCli();
    cargarAnios();
    cargarMarcas();
    listarCarrosByCliente();
    obtenerServicio();
    asignarVehiculoElegido();
  }

  void cargarAnios() {
    this.anios.add('2007');
    this.anios.add('2008');
    this.anios.add('2009');
    this.anios.add('2010');
    this.anios.add('2011');
    this.anios.add('2012');
    this.anios.add('2013');
    this.anios.add('2014');
    this.anios.add('2015');
    this.anios.add('2016');
    this.anios.add('2017');
    this.anios.add('2018');
    this.anios.add('2019');
    this.anios.add('2020');
    this.anios.add('2021');
  }

  void cargarMarcas() {
    this.marcas.add('Toyota');
    this.marcas.add('Volkswagen');
    this.marcas.add('Ford');
    this.marcas.add('Nissan');
    this.marcas.add('Honda');
    this.marcas.add('Hyundai');
    this.marcas.add('Chevrolet');
    this.marcas.add('Kia');
    this.marcas.add('Renault');
    this.marcas.add('Mercedes');
    this.marcas.add('Mazda');
    this.marcas.add('Jeep');
    this.marcas.add('Fiat');
    this.marcas.add('Geely');
    this.marcas.add('Changan');
    this.marcas.add('Mitsubishi');
    this.marcas.add('Suzuki');
  }

  Future getImage(int tipo) async {
    if (tipo == 1) {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxWidth: 450.0, maxHeight: 450.0);
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 450.0, maxHeight: 450.0);
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void obtenerServicio() async {
    this.servicio = await getServicio();
  }

  // Obtener tipos de vehiculos
  void listarTipoVehiculo({String message}) async {
    final Stream<List<TipoVehiculo>> stream = await obtenerTipoVehiculo();
    stream.listen((List<TipoVehiculo> _data) {
      setState(() {
        tipos = _data;
        // print("===============================");
        // print(jsonEncode(tipos));
        // print(jsonEncode(carros));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  // Obtener modelos de vehiculos
  void listarModelosVehiculo({String message}) async {
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
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listarCarrosByIdCli({String message}) async {
    final Stream<List<Vehiculo>> stream = await obtenerVehiculos();
    stream.listen((List<Vehiculo> _productos) {
      setState(() {
        carros = _productos;
        // print("===============================");
        // //print(carros);
        // print(jsonEncode(carros));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  // Obtener vehiculos por codigo cliente con información adicional
  void listarCarrosByCliente({String message}) async {
    String idCliente = currentUser.value.email.replaceAll('.', '|');
    final Stream<List<VehiculoA>> stream =
        await obtenerVehiculosPorCliente(idCliente);
    stream.listen((List<VehiculoA> _vehiculos) {
      setState(() {
        vehiculos = _vehiculos;
        asignarVehiculoElegido();
        // print("===============================");
        // //print(carros);
        // print(jsonEncode(carros));
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void eligeVehiculo(VehiculoA vehiculo) async {
    this.vehiculoElegido = vehiculo;
    String strVehiculo = vehiculoAToJson(vehiculo);
    setVehiculo(strVehiculo);
    // Navigator.pop(context);
    Navigator.of(context).pop(true);

    // Navigator.of(context).push(
    //   new MaterialPageRoute<Null>(
    //       builder: (BuildContext context) {
    //         return new ServicioPage(switchValue: null, valueChanged: null);
    //       },
    //       fullscreenDialog: true),
    // );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServicioPage(switchValue: null, valueChanged: null),
      ),
    );
  }

  //registrar en servidor
  void registrarVehiculo(Vehiculo newVehiculo) async {
    if (this.image == null) {
      showAlertDialogError(context, "Necesita agregar una imagen del vehiculo");
    } else {
      String base64Image = base64Encode(this.image.readAsBytesSync());
      String fileName = this.image.path.split("/").last;
      newVehiculo.foto = fileName;
      newVehiculo.imgFile = base64Image;
      newVehiculo.idCliente = currentUser.value.email;

      if (newVehiculo.placa == null) {
        showAlertDialogError(
            context, "Complete la información antes de guardar");
      } else {
        this.loading = true;
        setState(() {
          image = null;
        });

        var vehiculoResp = await guardarVehiculo(newVehiculo);
        this.loading = false;
        this.scaffoldKey?.currentState?.showSnackBar(SnackBar(
              content: Text('Se agregó correctamente'),
            ));
        setState(() {});
        Navigator.of(context).pop(true);
      }
    }
  }

  // GUARDAR EL MODELO DE VEHICULO
  void registrarModeloVehiculo() async {
    this.loading = true;
    var vehiculoResp = await guardarModeloVehiculo(vehiculomodelo);
    Navigator.of(context).pop(true);
    this.loading = false;
    this.scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('Se guardo correctamente!'),
          //backgroundColor: Theme.of(context).hintColor ,
        ));
    setState(() {
      this.listarModelosVehiculo();
    });
  }

  String RutaImg(String nombre) {
    return getRutaImg(nombre);
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

  showAlertDialog(BuildContext context, String id_vehiculo) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No!"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Si!"),
      onPressed: () async {
        await deleteVehiculo(id_vehiculo);

        // setReservaCompleta();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar Vehiculo"),
      content: Text("Deseas eliminar este vehiculo?"),
      actions: [
        cancelButton,
        continueButton,
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

  // Eliminar vehiculo
  Future<void> deleteVehiculo(String id_vehiculo) async {
    final Stream<bool> stream = await eliminarVehiculo(id_vehiculo);
    stream.listen((bool _data) {
      setState(() {
        vehiculos = [];
        listarCarrosByCliente();
        // if (_data) {
        //   listarCarrosByCliente();
        // } else {}
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    }, onDone: () {});
  }

  // Informaciion sobre tipod e vehiculo
  informacionConfirmacion(BuildContext context) {
    // set up the buttons
    // Widget cancelButton = FlatButton(
    //   child: Text("Todavia no!"),
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    // );
    Widget continueButton = FlatButton(
      child: Text("De acuerdo!"),
      onPressed: () {
        // setReservaCompleta();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Tamaño del Vehículo"),
      content: Text(
          "El tamaño elegido será verificado al momento de la recepción del vehículo"),
      actions: [
        //cancelButton,
        continueButton,
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

  void abrirNuevoVehiculo() {}
  void asignarVehiculoElegido() async{
    String vehiel = await getVehiculo();
    if (vehiel != null) {
      this.vehiculoElegido = vehiculoAFromJson(vehiel);
      this.vehiculoElegido.esElegido = true;
      for (var item in this.vehiculos) {
        if(item.id == this.vehiculoElegido.id){
          item.esElegido=true;
        }else{
          item.esElegido=false;
        }
      }
    
    } 
    print('asigna nuevo vehiculo');
    print(vehiculoAToJson(vehiculoElegido));
  }
}
