import 'package:carwash/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ContactanosPage extends StatefulWidget {
  ContactanosPage({Key key}) : super(key: key);

  @override
  _ContactanosPageState createState() => _ContactanosPageState();
}

class _ContactanosPageState extends StateMVC<ContactanosPage> {
  HomeController _con;
  double width_size;
  double height_size;

  _ContactanosPageState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Contactanos'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/img/fondo_car.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 100,
              ),
              child: Align(
                child: Image.asset(
                  'assets/img/isotipo.png',
                  width: 70,
                ),
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 220, left: 0, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Encuéntranos',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'en',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Final Calle 21 de Calacoto y',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'Avenida Costanera N° 100',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'La Paz / Bolivia',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width_size - 100,
                    height: height_size / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/img/mapa_ubicacion.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 1.0),
                    ),
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.greenAccent,
                      ),
                      title: Text('+591 77799292'),
                      onTap: () {
                        _con.launchWhatsApp(
                            phone: '+591 79521526',
                            message: 'Estoy interesado');
                        // Navigator.of(context).pushNamed('/AddVehiculo');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
