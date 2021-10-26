import 'package:carwash/src/models/vehiculoa.dart';
import 'package:carwash/src/pages/seleccionar_servicio_page.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:carwash/src/repository/vehiculo_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class VehiculoController extends ControllerMVC {
  List<VehiculoA> vehiculos = [];
  VehiculoA? vehiculoElegido;

  GlobalKey<ScaffoldState>? scaffoldKey;

  VehiculoController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listarCarrosByCliente();
  }

  String RutaImg(String nombre) {
    return getRutaImg(nombre);
  }

  // Obtener vehiculos por codigo cliente con información adicional
  void listarCarrosByCliente() async {
    String idCliente = currentUser!.value.email!.replaceAll('.', '|');
    final Stream<List<VehiculoA>> stream =
        await obtenerVehiculosPorCliente(idCliente);
    stream.listen((List<VehiculoA> _vehiculos) {
      setState(() {
        vehiculos = _vehiculos;
        // asignarVehiculoElegido();
      });
    }, onError: (a) {
      scaffoldKey!.currentState!.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener los vehículos'),
      ));
    }, onDone: () {});
  }

  void eligeVehiculo(BuildContext context, VehiculoA vehiculo) async {
    this.vehiculoElegido = vehiculo;
    String strVehiculo = vehiculoAToJson(vehiculo);
    setVehiculo(strVehiculo);
    Navigator.of(context).pop(true);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionarServicioPage(),
      ),
    );
  }

  void asignarVehiculoElegido() async {
    String vehiel = await getVehiculo();
    if (vehiel != null) {
      this.vehiculoElegido = vehiculoAFromJson(vehiel);
      this.vehiculoElegido!.esElegido = true;
      for (var item in this.vehiculos) {
        if (item.id == this.vehiculoElegido!.id) {
          item.esElegido = true;
        } else {
          item.esElegido = false;
        }
      }
    }
  }

  showAlertDialogError(BuildContext context, String mensaje) {
    Widget cancelButton = OutlinedButton(
      child: Text("Aceptar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No se guardo!"),
      content: Text(mensaje),
      actions: [
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
