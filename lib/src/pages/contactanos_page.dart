import 'dart:async';

import 'package:carwash/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ContactanosPage extends StatefulWidget {
  ContactanosPage({Key? key}) : super(key: key);

  @override
  _ContactanosPageState createState() => _ContactanosPageState();
}

class _ContactanosPageState extends StateMVC<ContactanosPage> {
  late HomeController _con;
  double? width_size;
  double? height_size;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-16.546246824383367, -68.07693076039882),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 45.8334901395799,
      target: LatLng(-16.546246824383367, -68.07693076039882),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);

  _ContactanosPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text('Contactanos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/img/fondo_car.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/img/isotipo.png',
                      width: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Encuéntranos en',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 25,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 250.0,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: GoogleMap(
                      markers: _markers,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        _goToTheLake();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).hintColor,
                        onPressed: () {
                          _con.launchMaps();
                        },
                        child: Text('Como llegar?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton.icon(
                        color: Colors.greenAccent,
                        textColor: Theme.of(context).hintColor,
                        onPressed: () {
                          _con.openwhatsapp2(context);
                          // _con.openwhatsapp(
                          //     context: context,
                          //     phone: '+59177799292',
                          //     message:
                          //         '¡Hola! \n Bienvenid@ a Procare Washing.\n ¿En que podemos ayudarte?');
                        },
                        label: const Text('EscrÍbenos al Whatsapp'),
                        icon: const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('ProCare Washing'),
            infoWindow: InfoWindow(
                title: 'ProCare Washing', snippet: 'Lavado de Autos'),
            position: LatLng(-16.546411816435178, -68.07691674993652)),
      );
    });
  }
}
