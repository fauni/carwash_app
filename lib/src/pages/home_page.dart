import 'dart:async';

import 'package:carwash/src/controllers/home_controller.dart';
import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/fecha_page.dart';
import 'package:carwash/src/pages/servicio_page.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:carwash/src/widgets/DrawerWidget.dart';
import 'package:carwash/src/widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const HomePage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage>
    with SingleTickerProviderStateMixin {
  Animation animationOpacity;
  AnimationController animationController;
  HomeController _con;
  double width_size;
  double height_size;

  _HomePageState() : super(HomeController()) {
    _con = controller;
  }

  List<bool> _isSelected = [false, true, false];
  bool _switchValue = false;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    Timer.run(() => _showAlert(context));
    // _con.verificarSiEstaAutentificado(context);
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();

    // _showAlert(context);
  }

  void openPublicaciones() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CarroPage(
            switchValue: _switchValue,
            valueChanged: (value) {
              _switchValue = value;
            },
          ),
        );
      },
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(context: context, builder: (context) => HomeSliderWidget());
  }

  @override
  void dispose() {
    animationController.dispose();
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
          title: Text(''),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              icon: FaIcon(FontAwesomeIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          // leading: new IconButton(
          //   icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
          //   // onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          // ),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: DrawerWidget(),
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
            Positioned(
              bottom: 300,
              // padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hola',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 40,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'bienvenido',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 30,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          currentUser.value.displayName + '!',
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
                          'Estas a unos pasos de',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'dejar tu auto al cuidado',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          'de profesionales',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     margin: EdgeInsets.only(bottom: 10),
            //     child: ToggleButtons(
            //       borderColor: Colors.transparent,
            //       borderWidth: null,
            //       selectedBorderColor: Colors.transparent,
            //       splashColor: Colors.transparent,
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(40),
            //           ),
            //           alignment: Alignment.center,
            //           padding:
            //               EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            //           width: _buttonWidth(context),
            //           child: Column(
            //             children: [
            //               Container(
            //                 width: 50,
            //                 height: 50,
            //                 child: Image.asset(
            //                   'assets/img/auto_off.png',
            //                 ),
            //               ),
            //               Text(
            //                 'Seleccionar',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //               Text(
            //                 'Auto',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           alignment: Alignment.center,
            //           padding:
            //               EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            //           width: _buttonWidth(context),
            //           child: Column(
            //             children: [
            //               Container(
            //                 width: 50,
            //                 height: 50,
            //                 child: Image.asset(
            //                   'assets/img/servicio_off.png',
            //                 ),
            //               ),
            //               Text(
            //                 'Seleccionar',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //               Text(
            //                 'Servicio',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           alignment: Alignment.center,
            //           padding:
            //               EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            //           width: _buttonWidth(context),
            //           child: Column(
            //             children: [
            //               Container(
            //                 width: 50,
            //                 height: 50,
            //                 child: Image.asset(
            //                   'assets/img/cuando_off.png',
            //                 ),
            //               ),
            //               Text(
            //                 'Seleccionar',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //               Text(
            //                 'Fecha y Hora',
            //                 style:
            //                     TextStyle(color: Theme.of(context).hintColor),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //       onPressed: (int index) {
            //         setState(() {
            //           for (int i = 0; i < _isSelected.length; i++) {
            //             _isSelected[i] = i == index;
            //           }

            //           if (index == 0) {
            //             Navigator.of(context).push(
            //               new MaterialPageRoute<Null>(
            //                   builder: (BuildContext context) {
            //                     return new CarroPage(
            //                         switchValue: null, valueChanged: null);
            //                   },
            //                   fullscreenDialog: true),
            //             );
            //             // showDialog<void>(
            //             //   context: context,
            //             //   builder: (BuildContext context) {
            //             //     return Dialog(
            //             //       child: CarroPage(
            //             //         switchValue: _switchValue,
            //             //         valueChanged: (value) {
            //             //           _switchValue = value;
            //             //         },
            //             //       ),
            //             //     );
            //             //   },
            //             // );
            //           } else if (index == 1) {
            //             Navigator.of(context).push(
            //               new MaterialPageRoute<Null>(
            //                   builder: (BuildContext context) {
            //                     return new ServicioPage(
            //                         switchValue: null, valueChanged: null);
            //                   },
            //                   fullscreenDialog: true),
            //             );
            //             // showDialog<void>(
            //             //   context: context,
            //             //   builder: (BuildContext context) {
            //             //     return Dialog(
            //             //       child: ServicioPage(
            //             //         switchValue: _switchValue,
            //             //         valueChanged: (value) {
            //             //           _switchValue = value;
            //             //         },
            //             //       ),
            //             //     );
            //             //   },
            //             // );
            //           } else {
            //             Navigator.of(context).push(
            //               new MaterialPageRoute<Null>(
            //                   builder: (BuildContext context) {
            //                     return new FechaPage(
            //                         switchValue: null, valueChanged: null);
            //                   },
            //                   fullscreenDialog: true),
            //             );
            //             // showDialog<void>(
            //             //   barrierDismissible: true,
            //             //   context: context,
            //             //   builder: (BuildContext context) {
            //             //     return Dialog(
            //             //       child: FechaPage(
            //             //         switchValue: _switchValue,
            //             //         valueChanged: (value) {
            //             //           _switchValue = value;
            //             //         },
            //             //       ),
            //             //     );
            //             //   },
            //             // );
            //           }
            //         });
            //       },
            //       isSelected: _isSelected,
            //       selectedColor: Theme.of(context).primaryColor,
            //       fillColor: Theme.of(context).primaryColor,
            //     ),
            //   ),
            // ),
            Positioned(
              width: width_size,
              bottom: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new CarroPage(
                                        switchValue: null, valueChanged: null);
                                  },
                                  fullscreenDialog: true),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/img/auto_on.png',
                              width: 100,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Seleccionar \n Auto',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new ServicioPage(
                                        switchValue: null, valueChanged: null);
                                  },
                                  fullscreenDialog: true),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/img/servicio_on.png',
                              width: 100,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Servicios \n',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new FechaPage(
                                        switchValue: null, valueChanged: null);
                                  },
                                  fullscreenDialog: true),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/img/cuando_on.png',
                              width: 100,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Cuando? \n',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

double _buttonWidth(BuildContext context) {
  final maxWidth = double.infinity;
  final buttonCount = 3;

  final width = (MediaQuery.of(context).size.width - 100) / buttonCount;
  if (width < maxWidth) {
    return width;
  } else {
    return maxWidth;
  }
}
