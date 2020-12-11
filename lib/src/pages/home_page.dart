import 'package:carwash/src/widgets/BotonMenuWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BotonMenuWidget(
                      color: Theme.of(context).accentColor,
                      text: Text('Boton'),
                      onPressed: () {},
                    ),
                    BotonMenuWidget(
                      color: Theme.of(context).accentColor,
                      text: Text('Boton'),
                      onPressed: () {},
                    ),
                    BotonMenuWidget(
                      color: Theme.of(context).accentColor,
                      text: Text('Boton'),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
