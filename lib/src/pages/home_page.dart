import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/fecha_page.dart';
import 'package:carwash/src/pages/servicio_page.dart';
import 'package:carwash/src/widgets/DrawerWidget.dart';
import 'package:carwash/src/widgets/ServiciosWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.sort),
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
              padding: const EdgeInsets.only(
                  top: 30, left: 10, right: 10, bottom: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      child: Image.asset('assets/img/main_carwash.jpg'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  ServiciosWidget()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  borderWidth: null,
                  selectedBorderColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      width: _buttonWidth(context),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              'assets/img/auto_off.png',
                            ),
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          Text(
                            'Auto',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
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
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              'assets/img/servicio_off.png',
                            ),
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          Text(
                            'Servicio',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
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
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              'assets/img/cuando_off.png',
                            ),
                          ),
                          Text(
                            'Seleccionar',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          Text(
                            'Fecha y Hora',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }

                      if (index == 0) {
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
                      }
                    });
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
  final maxWidth = double.infinity;
  final buttonCount = 3;

  final width = (MediaQuery.of(context).size.width - 100) / buttonCount;
  if (width < maxWidth) {
    return width;
  } else {
    return maxWidth;
  }
}
