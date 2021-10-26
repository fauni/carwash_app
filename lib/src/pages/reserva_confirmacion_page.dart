import 'package:flutter/material.dart';

class ReservaConfirmacionPage extends StatefulWidget {
  @override
  _ReservaConfirmacionPageState createState() =>
      _ReservaConfirmacionPageState();
}

class _ReservaConfirmacionPageState extends State<ReservaConfirmacionPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pushNamed('/Pages')),
          // actions: <Widget>[
          //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          // ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/auto_on.png',
                    width: 100,
                  ),
                  Text(
                    'La reserva fue creada exitosamente!',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Te pedimos que llegues de manera puntual para no generar retrasos!')
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 50.0,
                child: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).hintColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Main');
                  },
                  label: const Text('Volver al Inicio'),
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).hintColor,
                    size: 30,
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
    );
  }
}
