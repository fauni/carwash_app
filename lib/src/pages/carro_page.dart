import 'package:carwash/src/controllers/carro_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CarroPage extends StatefulWidget {
  CarroPage({Key key}) : super(key: key);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends StateMVC<CarroPage> {
  CarroController _con;

  _CarroPageState() : super(CarroController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    // _con.listarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.access_alarm_outlined),
                title: Text(_con.productos.elementAt(index).idProducto),
                subtitle: Text(_con.productos.elementAt(index).nombreProducto));
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 5,
            );
          },
          itemCount: _con.productos.length,
        ),
      ),
    );
  }
}
