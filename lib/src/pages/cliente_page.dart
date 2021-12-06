import 'dart:convert';

import 'package:carwash/src/controllers/cliente_controller.dart';
import 'package:carwash/src/models/cliente.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart' as userRepo;

class ClientePage extends StatefulWidget {
  Cliente? cliente;
  String? _heroTag;

  ClientePage({Key? key, this.cliente}) {
    // _heroTag = this.routeArgument.param[0] as String;
  }

  @override
  ClientePageState createState() => ClientePageState();
}

class ClientePageState extends StateMVC<ClientePage> {
  late ClienteController _con;

  ClientePageState() : super(ClienteController()) {
    _con = controller as ClienteController;
  }

  @override
  void initState() {
    _con.cliente = widget.cliente!;
    super.initState();
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
          ListView(
            padding: EdgeInsets.only(top: 100.0),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/logo_horizontal.png',
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Es necesario completar o confirmar la siguiente información:',
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        // enabled: false,
                        initialValue: widget.cliente!.codigoCliente == null
                            ? userRepo.currentUser!.value.displayName != null
                                ? userRepo.currentUser!.value.displayName
                                : userRepo.currentUser!.value.email!
                                    .split('@')[0]
                            : _con.cliente.nombreCompleto,
                        onSaved: (input) => _con.cliente.nombreCompleto = input,
                        style: TextStyle(color: Theme.of(context).hintColor),
                        decoration: InputDecoration(
                            labelText: 'Ingresa tu Nick Name',
                            hintText: 'Ingrese tu Nick Name',
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: userRepo.currentUser!.value.email,
                        onSaved: (input) => _con.cliente.email = input,
                        style: TextStyle(color: Theme.of(context).hintColor),
                        decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            hintText: 'Ingrese su Correo Electrónico',
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /*
                      TextFormField(
                        initialValue: widget.cliente!.codigoCliente == null
                            ? userRepo.currentUser!.value.phoneNumber
                            : widget.cliente!.telefono,
                        onSaved: (input) => _con.cliente.telefono = input,
                        validator: (input) => input!.length == 8
                            ? null
                            : 'El numero de telefono es invalido',
                        style: TextStyle(color: Theme.of(context).hintColor),
                        decoration: InputDecoration(
                            labelText: 'Número de Celular',
                            hintText: 'Ingrese su Nro. de Celular',
                            hintStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor)),
                      ),
                      */
                      const SizedBox(
                        height: 20,
                      ),
                      widget.cliente!.email == null
                          ? ButtonTheme(
                              minWidth: double.infinity,
                              height: 50.0,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).hintColor,
                                onPressed: () {
                                  _con.registrar(context);
                                },
                                child: Text('Registrate Ahora'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                          : ButtonTheme(
                              minWidth: double.infinity,
                              height: 50.0,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).hintColor,
                                onPressed: () {
                                  _con.actualizar(context);
                                },
                                child: Text('Actualizar Datos'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
