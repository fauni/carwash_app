import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/pages/carro_page.dart';
import 'package:carwash/src/pages/cliente_page.dart';
import 'package:carwash/src/pages/compartir_page.dart';
import 'package:carwash/src/pages/contactanos_page.dart';
import 'package:carwash/src/pages/detalle_reserva_page.dart';
import 'package:carwash/src/pages/detalle_servicio_page.dart';
import 'package:carwash/src/pages/en_vivo_page.dart';
import 'package:carwash/src/pages/home_page.dart';
import 'package:carwash/src/pages/login_page.dart';
import 'package:carwash/src/pages/main_page.dart';
import 'package:carwash/src/pages/reserva_confirmacion_page.dart';
import 'package:carwash/src/pages/reservas_page.dart';
import 'package:carwash/src/pages/splash_pages.dart';
import 'package:carwash/src/pages/vehiculo_page.dart';
import 'package:carwash/src/pages/capturas_page.dart';
import 'package:carwash/src/widgets/AddVehiculoWidget.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case '/Debug':
      //   return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Cliente':
        return MaterialPageRoute(
            builder: (_) => ClientePage(cliente: args as Cliente));
      // case '/MobileVerification':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/MobileVerification2':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      // case '/ForgetPassword':
      //   return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/Main':
        return MaterialPageRoute(builder: (_) => MainPage());

      case '/Compartir':
        return MaterialPageRoute(
            builder: (_) => CompartirPage(id_reserva: args as String));
      // case '/Carros':
      //   return MaterialPageRoute(builder: (_) => CarroPage());

      case '/DetalleReserva':
        return MaterialPageRoute(
            builder: (_) =>
                DetalleReservaPage(routeArgument: args as RouteArgument));

      case '/ConfirmacionReserva':
        return MaterialPageRoute(builder: (_) => ReservaConfirmacionPage());

      case '/CapturasReserva':
        return MaterialPageRoute(
            builder: (_) => CapturasPage(routeArgument: args as RouteArgument));
      /*
      case '/Menu':
        return MaterialPageRoute(builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      */

      case '/Servicio':
        return MaterialPageRoute(
            builder: (_) =>
                DetalleServicioPage(routeArgument: args as RouteArgument));
      // case '/Brand':
      //   return MaterialPageRoute(builder: (_) => BrandWidget(routeArgument: args as RouteArgument));
      // case '/Brands':
      //   return MaterialPageRoute(builder: (_) => BrandsWidget());
      // case '/Category':
      // return MaterialPageRoute(builder: (_) => CategoryWidget(routeArgument: args as RouteArgument));
      // case '/Categories':
      //   return MaterialPageRoute(builder: (_) => CategoriesWidget());

      // case '/Cart':
      //   return MaterialPageRoute(builder: (_) => CartWidget(routeArgument: args as RouteArgument));
      // case '/DeliveryPickup':
      //   return MaterialPageRoute(builder: (_) => DeliveryPickupWidget(routeArgument: args as RouteArgument));
      // case '/Tracking':
      //   return MaterialPageRoute(builder: (_) => TrackingWidget(routeArgument: args as RouteArgument));
      // case '/Reviews':
      //   return MaterialPageRoute(builder: (_) => ReviewsWidget(routeArgument: args as RouteArgument));
      // case '/PaymentMethod':
      //   return MaterialPageRoute(builder: (_) => PaymentMethodsWidget());
      // case '/DeliveryAddresses':
      //   return MaterialPageRoute(builder: (_) => DeliveryAddressesWidget());
      // case '/DeliveryPickup':
      //   return MaterialPageRoute(builder: (_) => DeliveryPickupWidget(routeArgument: args as RouteArgument));
      // case '/Checkout':
      //   return MaterialPageRoute(builder: (_) => CheckoutWidget());
      // case '/CashOnDelivery':
      //   return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Cash on Delivery')));
      // case '/PayOnPickup':
      //   return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Pay on Pickup')));
      // case '/PayPal':
      //   return MaterialPageRoute(builder: (_) => PayPalPaymentWidget(routeArgument: args as RouteArgument));
      // case '/RazorPay':
      //   return MaterialPageRoute(builder: (_) => RazorPayPaymentWidget(routeArgument: args as RouteArgument));
      // case '/OrderSuccess':
      //   return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: args as RouteArgument));
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
      // case '/Settings':
      //   return MaterialPageRoute(builder: (_) => SettingsWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
