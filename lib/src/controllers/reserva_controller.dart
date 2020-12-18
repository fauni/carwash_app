import 'dart:convert';

import 'package:carwash/generated/i18n.dart';
import 'package:carwash/src/models/reserva.dart';
import 'package:carwash/src/models/vehiculo.dart';
import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/repository/reserva_repository.dart';
//import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:carwash/src/repository/servicio_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReservaController extends ControllerMVC {
  Reserva reserva;
  String strReserva = '';
  Map <String,dynamic> reservaCompleta = {"vehiculo" : "", "servicios":"", "fecha" :""};

  GlobalKey<ScaffoldState> scaffoldKey;

  ReservaController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    
  }
  
  void eligeReserva(Reserva reserv) async{
      this.reserva = reserv;
      String strRes = reservaToJson(reserva);
      setReserva(strRes);
      print('_________en string____________');
      print (await getReserva());
  }
  void setReservaCompleta()async {
    String strVehiculo = await getVehiculo();  
    this.reservaCompleta["vehiculo"] = json.decode(strVehiculo) ;
    String strServicios = await getServicio();  
    this.reservaCompleta["servicios"] = json.decode(strServicios);
    String strFecha  = await getReserva();
    this.reservaCompleta["fecha"] = json.decode(strFecha);
    print(json.encode(this.reservaCompleta));
    print('--------respuesta del post:----------');
    var respuesta = registrarReserva(json.encode(this.reservaCompleta)) ;

  }
}
