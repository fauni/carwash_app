import 'package:cached_network_image/cached_network_image.dart';
// Este es el que se usa
import 'package:carwash/src/controllers/vehiculo_controller.dart';
import 'package:carwash/src/pages/agregar_vehiculo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeleccionarVehiculoPage extends StatefulWidget {
  SeleccionarVehiculoPage();

  @override
  State<StatefulWidget> createState() {
    return SeleccionarVehiculoPageState();
  }
}

class SeleccionarVehiculoPageState extends StateMVC<SeleccionarVehiculoPage> {
  bool selected = false;
  late VehiculoController _con;

  bool? _switchValue;

  SeleccionarVehiculoPageState() : super(VehiculoController()) {
    _con = controller as VehiculoController;
  }
  @override
  void initState() {
    // _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione un Vehículo'),
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  _con.vehiculos.isEmpty
                      ? Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Theme.of(context).accentColor),
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
                                'No tiene vehiculos',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: CheckboxListTile(
                                value: _con.vehiculos
                                            .elementAt(index)
                                            .esElegido !=
                                        null
                                    ? _con.vehiculos.elementAt(index).esElegido
                                    : false,
                                onChanged: (bool? value) {
                                  _con.eligeVehiculo(
                                      context, _con.vehiculos.elementAt(index));
                                  _con.asignarVehiculoElegido();
                                  setState(() {});
                                },
                                secondary: CachedNetworkImage(
                                  imageUrl: _con.RutaImg(
                                      _con.vehiculos.elementAt(index).foto!),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          )),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                title: Text(
                                  _con.vehiculos.elementAt(index).placa! +
                                      ' - ' +
                                      _con.vehiculos.elementAt(index).marca!,
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                ),
                                subtitle: Text(
                                  _con.vehiculos.elementAt(index).modelo! +
                                      ' ' +
                                      _con.vehiculos.elementAt(index).anio! +
                                      ' - ' +
                                      _con.vehiculos.elementAt(index).tamanio!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Theme.of(context).accentColor,
                              height: 15,
                            );
                          },
                          itemCount: _con.vehiculos.length,
                        ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 1.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Theme.of(context).hintColor,
                        size: 50,
                      ),
                      title: Text('Agregar un Vehiculo'),
                      subtitle: Text('Nuevo Vehiculo'),
                      onTap: () {
                        _abrirNuevoVehiculo();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   child: ButtonTheme(
                  //     minWidth: double.infinity,
                  //     height: 50.0,
                  //     child: RaisedButton.icon(
                  //       onPressed: () {},
                  //       color: Theme.of(context).primaryColor,
                  //       textColor: Theme.of(context).hintColor,
                  //       icon: Icon(Icons.next_plan),
                  //       label: Text('Seleccionar Servicio'),
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton.icon(
                        onPressed: () => Navigator.of(context).pop(true),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).hintColor,
                        icon: Image.asset(
                          'assets/img/isotipo.png',
                          width: 30,
                        ),
                        label: Text('Volver al Inicio'),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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

  _abrirNuevoVehiculo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgregarVehiculoPage(
          onDismissed: () {
            print('Cerrar despues de agregar nuevo vehiculo');
          },
        ),
      ),
    );

    if (result != null) {
      if (result) {
        _con.listarCarrosByCliente();
      }
    }
  }
}
