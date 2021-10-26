import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:carwash/src/models/usuario.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/user_repository.dart' as repository;

class LoginController extends ControllerMVC {
  bool supportsAppleSignIn = false;

  Usuario usuario = new Usuario();
  bool isLoggedIn = false;

  GlobalKey<ScaffoldState>? scaffoldKey;

  LoginController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  String usuario_actual = '';

  void verificaPlataforma() {
    if (Platform.isIOS) {
      supportsAppleSignIn = true;
    }
  }

  void login(BuildContext context) async {
    repository.login().then((value) {
      if (value != null && value.verifyEmail != null) {
        // Navigator.of(context).pushReplacementNamed('/Pages');
        Navigator.of(context).pushReplacementNamed('/Main');
      } else {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text('Ocurrio un error al autentificar'),
        ));
      }
    }).catchError((e) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('No se pudo ingresar'),
      ));
    }).whenComplete(() {});
  }

  Future<void> googleSignOut() async {
    logout();
  }

  Future<void> facebookSignIn(BuildContext context) async {
    repository.loginFacebook().then((value) {
      if (value != null && value.verifyEmail != null) {
        // Navigator.of(context).pushReplacementNamed('/Pages');
        Navigator.of(context).pushReplacementNamed('/Main');
      } else {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text('Ocurrio un error al autentificar'),
        ));
      }
    }).catchError((e) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('No se pudo ingresar'),
      ));
    }).whenComplete(() {});
  }

  Future<void> appleSignIn(BuildContext context) async {
    repository.loginApple().then((value) {
      if (value != null && value.verifyEmail != null) {
        // Navigator.of(context).pushReplacementNamed('/Pages');
        Navigator.of(context).pushReplacementNamed('/Main');
      } else {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text('Ocurrio un error al autentificar'),
        ));
      }
    }).catchError((e) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('No se pudo ingresar'),
      ));
    }).whenComplete(() {});
  }

  void obtenerUsuario() async {
    final u = FirebaseAuth.instance.currentUser;
    this.usuario = await getCurrentUser();
    this.usuario_actual = await getUsuario();
  }
}
