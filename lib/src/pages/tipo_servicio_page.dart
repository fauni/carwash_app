import 'package:carwash/src/pages/seleccionar_vehiculo_page.dart';
import 'package:flutter/material.dart';

class TipoServicioPage extends StatelessWidget {
  TipoServicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(true),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Image(
                width: 50,
                image: AssetImage('assets/img/isotipo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Seleccione el Tipo de Servicio',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SeleccionarVehiculoPage(tipoServicio: 'P')
                        // builder: (context) => SeleccionarVehiculoPage(),
                        ),
                  );
                  if (result) {}
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'SERVICIOS',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 08,
                      ),
                      Text(
                        'ProCare',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'WASHING',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeleccionarVehiculoPage(
                              tipoServicio: 'N',
                            )
                        // builder: (context) => SeleccionarVehiculoPage(),
                        ),
                  );
                  if (result) {}
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    border: Border.all(
                      color: Theme.of(context).hintColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'SERVICIOS',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 08,
                      ),
                      Container(
                        child: Text(
                          '             ___',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                      Text(
                        'CARPRO',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
