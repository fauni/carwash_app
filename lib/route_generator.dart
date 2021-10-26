import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/pages/capturas_page.dart';
import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/cliente_page.dart';
import 'package:carwash/src/pages/compartir_page.dart';
import 'package:carwash/src/pages/contactanos_page.dart';
import 'package:carwash/src/pages/detalle_reserva_page.dart';
import 'package:carwash/src/pages/detalle_servicio_page.dart';
import 'package:carwash/src/pages/en_vivo_page.dart';
import 'package:carwash/src/pages/login_page.dart';
import 'package:carwash/src/pages/main_page.dart';
import 'package:carwash/src/pages/reserva_confirmacion_page.dart';
import 'package:carwash/src/pages/reservas_page.dart';
import 'package:carwash/src/pages/splash_pages.dart';
import 'package:flutter/material.dart';
import 'package:carwash/src/pages/vehiculo_page.dart';
import 'package:carwash/src/widgets/add_vehiculo_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Cliente':
        return MaterialPageRoute(
            builder: (_) => ClientePage(cliente: args as Cliente));
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      // case '/Pages':
      //   return MaterialPageRoute(builder: (_) => HomePage());

      case '/Main':
        return MaterialPageRoute(builder: (_) => MainPage());

      case '/Compartir':
        return MaterialPageRoute(
          builder: (_) => CompartirPage(idReserva: args as String),
        );

      case '/DetalleReserva':
        return MaterialPageRoute(
            builder: (_) =>
                DetalleReservaPage(routeArgument: args as RouteArgument));

      case '/ConfirmacionReserva':
        return MaterialPageRoute(builder: (_) => ReservaConfirmacionPage());

      case '/CapturasReserva':
        return MaterialPageRoute(
            builder: (_) => CapturasPage(routeArgument: args as RouteArgument));

      case '/Servicio':
        return MaterialPageRoute(
            builder: (_) =>
                DetalleServicioPage(routeArgument: args as RouteArgument));
      case '/Vehiculo':
        return MaterialPageRoute(builder: (_) => VehiculoPage());
      case '/AddVehiculo':
        return MaterialPageRoute(builder: (_) => AddVehiculoWidget());
      case '/NuevoVehiculoHome':
        return MaterialPageRoute(
            builder: (_) => CarroPage(switchValue: null, valueChanged: null));
      case '/Reservas':
        return MaterialPageRoute(builder: (_) => ReservasPage());
      case '/Contactanos':
        return MaterialPageRoute(builder: (_) => ContactanosPage());
      case '/EnVivo':
        return MaterialPageRoute(builder: (_) => EnVivoPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: SizedBox(height: 0)));
    }
  }
}
