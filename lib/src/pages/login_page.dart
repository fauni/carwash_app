import 'package:carwash/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends StateMVC<LoginPage> {
  LoginController _con;

  LoginPageState() : super(LoginController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _con.isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_con.user.photoURL),
                  ),
                  Text(_con.user.email),
                  RaisedButton(
                    onPressed: () => _con.googleSignOut(),
                    child: Text('Cerrar Sesión'),
                  ),
                ],
              )
            : RaisedButton(
                onPressed: () {
                  _con.login().then((value) {
                    Navigator.of(context).pushReplacementNamed('/Pages');
                  });
                },
                child: Text('Ingresar'),
              ),
      ),
    );
  }
}
