import 'dart:convert';

import 'package:carwash/src/models/servicio.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ServicioController extends ControllerMVC {
  List<Servicio> servicios = [];

  List <Servicio> serviciosElegidos = [];

  List<Servicio> serviciosGeneral = [];
  List<Servicio> serviciosAdicionales = [];
  List<Servicio> serviciosMotos = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  ServicioController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarServicios();
    listarServiciosAdicionales();
    listarServiciosMotos();
  }

  void listarServicios({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('1');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        // servicios = _servicios;
        serviciosGeneral = _servicios;
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listarServiciosMotos({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('2');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosMotos = _servicios;
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listarServiciosAdicionales({String message}) async {
    final Stream<List<Servicio>> stream = await obtenerServiciosPorTipo('3');
    stream.listen((List<Servicio> _servicios) {
      setState(() {
        serviciosAdicionales = _servicios;
      });
    }, onError: (a) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los servicios'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
  void insertaServElegidos(Servicio serv)async{
    bool seElimino = eliminaServElegido(serv);
    
    if(seElimino == false){
       this.serviciosElegidos.add(serv); 
    }
    
    List <dynamic> lservJson = new List <dynamic>() ;  
    for(var itms in this.serviciosElegidos){
      lservJson.add(itms.toJson());
    }

    String servString = json.encode(lservJson);
    setServicio(servString);
    print('_____en share preferences:______');
    print( await getServicio());
    
  }
  bool eliminaServElegido(Servicio serv){
  List<Servicio> srvTemp = [];    
    bool resp=false;
    for(var srv in serviciosElegidos){
      if(serv.id.compareTo(srv.id) != 0  ){
        srvTemp.add(srv);
      }else{
          resp=true;
      }
    }
    if(resp){
      serviciosElegidos = srvTemp;
    }
    return resp;
  }
}
