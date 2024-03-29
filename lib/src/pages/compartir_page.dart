import 'package:carwash/src/controllers/compartir_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CompartirPage extends StatefulWidget {
  String? idReserva;
  CompartirPage({Key? key, this.idReserva}) {
    // _heroTag = this.routeArgument.param[0] as String;
  }

  @override
  CompartirPageState createState() => CompartirPageState();
}

class CompartirPageState extends StateMVC<CompartirPage> {
  late CompartirController _con;

  CompartirPageState() : super(CompartirController()) {
    _con = controller as CompartirController;
  }

  @override
  void initState() {
    _con.obtenerAtencionPorReserva(widget.idReserva!);
    _con.cliente.nombreCompleto = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/img/fondo_car.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 200.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://procarewashing.com/apicwash/assets/capturas_vehiculos/' +
                              widget.idReserva! +
                              '/finalPub.png'),
                    ),
                  ),
                ),

                // Hola Franz.
                // Contarte que tu auto quedó como nuevo!
                // Puedes pasar a recogerlo.
                // Gracias por confiar en Procare Washing.
                // Tu auto, nuestro cuidado
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hola' +
                            // _con.cliente.nombreCompleto??'' +
                            ', contarte que tu vehículo quedó como nuevo!. Puedes pasar a recogerlo.',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Gracias por confiar en Procare Washing. Tu auto, nuestro cuidado.',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Comparte tu experiencia con tus amigos.',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonTheme(
                        minWidth: 300,
                        height: 50,
                        buttonColor: Colors.blue.shade900,
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            _con.compartirReserva();
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Compartir en Facebook',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ButtonTheme(
                        minWidth: 300,
                        height: 50,
                        buttonColor: Theme.of(context).primaryColor,
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/Main');
                            // Navigator.pop(context);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.home,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Volver al Inicio',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
