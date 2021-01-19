import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:carwash/src/helpers/helper.dart';
import 'package:carwash/src/models/usuario.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../repository/user_repository.dart' as repository;

class LoginController extends ControllerMVC {
  Usuario usuario = new Usuario();
  bool isLoggedIn = false;

  GlobalKey<ScaffoldState> scaffoldKey;

  OverlayEntry loader;
  LoginController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  String usuario_actual = '';

  void login() async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);
    repository.login().then((value) {
      if (value != null && value.verifyEmail != null) {
        Navigator.of(context).pushReplacementNamed('/Pages');
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Ocurrio un error al autentificar'),
        ));
      }
    }).catchError((e) {
      loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No se pudo ingresar'),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<void> googleSignOut() async {
    logout();
    // await _auth.signOut().then((onValue) {
    //   _googleSignIn.signOut();
    //   setState(() {
    //     isLoggedIn = false;
    //   });
    // });
  }

  Future<void> facebookSignIn() async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);
    repository.loginFacebook().then((value) {
      if (value != null && value.verifyEmail != null) {
        Navigator.of(context).pushReplacementNamed('/Pages');
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Ocurrio un error al autentificar'),
        ));
      }
    }).catchError((e) {
      loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('No se pudo ingresar'),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void obtenerUsuario() async {
    final u = FirebaseAuth.instance.currentUser;
    this.usuario = await getCurrentUser();
    this.usuario_actual = await getUsuario();
  }
  // Future<void> signOutGoogle() async {
  //   await googleSignIn.signOut();

  //   print('Se salio el usuario');
  // }
  // void listarTipoVehiculo({String message}) async {
  //   final Stream<List<TipoVehiculo>> stream = await obtenerTipoVehiculo();
  //   stream.listen((List<TipoVehiculo> _data) {
  //     setState(() {
  //       tipos = _data;
  //       print("===============================");
  //       print(jsonEncode(tipos));
  //       // print(jsonEncode(carros));
  //     });
  //   }, onError: (a) {
  //     scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text(S.current.verify_your_internet_connection),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }

}
