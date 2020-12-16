import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/fecha_page.dart';
import 'package:carwash/src/pages/servicio_page.dart';
import 'package:carwash/src/widgets/CarItemWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> _isSelected = [false, true, false];
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Theme.of(context).hintColor),
            onPressed: () {},
            // onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
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
              padding: const EdgeInsets.only(left: 55, bottom: 175),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Hola',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 65,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text(
                    'bienvenido',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 40,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text(
                    'Favio!',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 40,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text(
                    'Estas a unos pasos de',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text(
                    'dejar tu auto al cuidado',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                  Text(
                    'de profesionales.',
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: ToggleButtons(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      width: _buttonWidth(context),
                      child: Column(
                        children: [
                          Icon(
                            Icons.car_repair,
                            color: Theme.of(context).accentColor,
                            size: 40.0,
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          Text(
                            'Auto',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      width: _buttonWidth(context),
                      child: Column(
                        children: [
                          Icon(
                            Icons.design_services,
                            color: Theme.of(context).accentColor,
                            size: 40.0,
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          Text(
                            'Servicio',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      width: _buttonWidth(context),
                      child: Column(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Theme.of(context).accentColor,
                            size: 40.0,
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          Text(
                            'Fecha y Hora',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),
                    // Icon(
                    //   Icons.bluetooth,
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // Icon(Icons.wifi, color: Theme.of(context).primaryColor),
                    // Icon(Icons.flash_on_outlined,
                    //     color: Theme.of(context).primaryColor)
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }

                      if (index == 0) {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CarroPage(
                              switchValue: _switchValue,
                              valueChanged: (value) {
                                _switchValue = value;
                              },
                            );
                          },
                        );
                      } else if (index == 1) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: ServicioPage(
                                switchValue: _switchValue,
                                valueChanged: (value) {
                                  _switchValue = value;
                                },
                              ),
                            );
                          },
                        );
                        // showModalBottomSheet<void>(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return ServicioPage(
                        //       switchValue: _switchValue,
                        //       valueChanged: (value) {
                        //         _switchValue = value;
                        //       },
                        //     );
                        //   },
                        // );
                      } else {
                        showDialog<void>(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: FechaPage(
                                switchValue: _switchValue,
                                valueChanged: (value) {
                                  _switchValue = value;
                                },
                              ),
                            );
                          },
                        );
                        // showDialog<void>(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return FechaPage(
                        //       switchValue: _switchValue,
                        //       valueChanged: (value) {
                        //         _switchValue = value;
                        //       },
                        //     );
                        //   },
                        // );
                      }
                      // _isSelected[index] = !_isSelected[index];
                    });
                    print('==============================');
                    print(index);
                  },
                  isSelected: _isSelected,
                  selectedColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

double _buttonWidth(BuildContext context) {
  final maxWidth = 120.0;
  final buttonCount = 3;

  final width = (MediaQuery.of(context).size.width - 100) / buttonCount;
  if (width < maxWidth) {
    return width;
  } else {
    return maxWidth;
  }
}
