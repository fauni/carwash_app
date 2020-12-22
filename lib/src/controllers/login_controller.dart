import 'dart:convert';

import 'package:carwash/src/models/usuario.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginController extends ControllerMVC {
  bool isLoggedIn = false;

  GlobalKey<ScaffoldState> scaffoldKey;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Usuario usuario = new Usuario();
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  LoginController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  String usuario_actual = '';

  Future<void> login() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = (await _auth.signInWithCredential(credential));

      user = result.user;

      usuario.uid = user.uid;
      usuario.displayName = user.displayName;
      usuario.email = user.email;
      usuario.phoneNumber = user.phoneNumber;
      usuario.photoUrl = user.photoURL;
      usuario.verifyEmail = user.emailVerified;

      setState(() {
        // print(jsonEncode(usuario));
        setCurrentUser(jsonEncode(usuario));
        // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages');
        isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> googleSignOut() async {
    logout();
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isLoggedIn = false;
      });
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
