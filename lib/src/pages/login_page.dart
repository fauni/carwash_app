import 'package:carwash/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as userRepo;

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
    super.initState();
    _con.verificaPlataforma();
    if (userRepo.currentUser.value.email != null) {
      // Navigator.of(context).pushReplacementNamed('/Pages');
      Navigator.of(context).pushReplacementNamed('/Main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/fondo_car.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo_horizontal.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Ingresar con:',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50,
                  child: RaisedButton.icon(
                    color: Colors.transparent,
                    textColor: Theme.of(context).hintColor,
                    onPressed: () {
                      _con.login();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    label: Text('Google'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.blue, //Theme.of(context).primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50,
                  child: RaisedButton.icon(
                    color: Colors.transparent,
                    textColor: Theme.of(context).hintColor,
                    onPressed: () {
                      _con.facebookSignIn();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    label: Text('Facebook'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.blue, //Theme.of(context).primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _con.supportsAppleSignIn
                    ? ButtonTheme(
                        minWidth: double.infinity,
                        height: 50,
                        child: RaisedButton.icon(
                          color: Colors.black,
                          textColor: Theme.of(context).hintColor,
                          onPressed: () {
                            _con.appleSignIn();
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.white,
                            size: 35,
                          ),
                          label: Text('Apple'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors
                                  .white, //Theme.of(context).primaryColor,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      )
                    : Container()
                // ButtonTheme(
                //   minWidth: double.infinity,
                //   height: 50.0,
                //   child: RaisedButton(
                //     color: Theme.of(context).primaryColor,
                //     textColor: Theme.of(context).hintColor,
                //     onPressed: () {
                //       // _con.setReservaCompleta();
                //     },
                //     child: Text('Enviar Reserva'),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
