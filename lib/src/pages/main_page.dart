// Este es el que se usa actualmente

import 'dart:async';

import 'package:carwash/src/controllers/main_controller.dart';
import 'package:carwash/src/pages/tipo_servicio_page.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:carwash/src/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:carwash/src/widgets/home_slider_widget.dart';

import 'indicator_page.dart';
import 'seleccionar_vehiculo_page.dart';

class MainPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  MainPage({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends StateMVC<MainPage>
    with SingleTickerProviderStateMixin {
  Animation? animationOpacity;
  AnimationController? animationController;
  late MainController _con;
  double? width_size;
  double? height_size;

  _MainPageState() : super(MainController()) {
    _con = controller as MainController;
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      _showAlert(context);
    });

    // TODO: implement initState
    super.initState();
    // final pushProvider = new PushNotificationsProviders();
    // pushProvider.initNotifications();

    /*
    pushProvider.mensaje.listen((argumento) {
      print("=======================ARGUMENTO NOTIFICACION===============");
      print(argumento);

      Navigator.of(context).pop(context);
      Navigator.of(context)
          .pushReplacementNamed('/Compartir', arguments: argumento);
    });
    */
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animationController!.forward();
  }

  void _showAlert(BuildContext context) {
    showDialog(context: context, builder: (context) => HomeSliderWidget());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(''),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const FaIcon(FontAwesomeIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: DrawerWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _con.platform.version();
          },
          child: Icon(
            Icons.share,
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
            Padding(
              padding: const EdgeInsets.only(
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
            Positioned(
              bottom: 200,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hola',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 28,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'bienvenid@',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 23,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          currentUser!.value.displayName == null
                              ? ''
                              : currentUser!.value.displayName!,
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 23,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Estás a unos pasos de',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'dejar tu vehículo al cuidado',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'de profesionales',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _con.reservasInner.isEmpty
                ? Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndicatorPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 110),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                          ),
                          height: 65,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '¿Nuevo en la App?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    '¡Te ayudamos en tu primera experiencia!',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Theme.of(context).accentColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TipoServicioPage()
                          // builder: (context) => SeleccionarVehiculoPage(),
                          ),
                    );
                    if (result) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    height: 65,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/cuando_off.png',
                          height: 50,
                        ),
                        const Text(
                          'Realizar mi Reserva',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Image.asset(
                          'assets/img/servicio_off.png',
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
