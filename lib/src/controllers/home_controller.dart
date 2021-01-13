import 'dart:io';

import 'package:carwash/src/models/cliente.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/repository/cliente_repository.dart';
import 'package:carwash/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/helper.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart' as userRepo;

class HomeController extends ControllerMVC {
  HomeController() {}

  // Future<void> listenForTrendingProducts() async {
  //   final Stream<Product> stream = await getTrendingProducts();
  //   stream.listen((Product _product) {
  //     setState(() => trendingProducts.add(_product));
  //   }, onError: (a) {
  //     print(a);
  //   }, onDone: () {});
  // }

  Future<void> verificarSiEstaAutentificado(BuildContext context) async {
    // print('Verificaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    if (currentUser.value.uid == null) {
      Navigator.of(context).pushNamed('/Login');
    }
  }

  Future<void> validaRegistroCliente() async {
    final Stream<Cliente> stream =
        await obtenerClienteXEmail(currentUser.value.email);
    stream.listen((Cliente _cliente) {
      setState(() {
        if (_cliente.codigoCliente == null) {
          Navigator.of(context).pushNamed('/Cliente', arguments: new Cliente());
        } else {
          if (_cliente.codigoCliente == '0') {
            Navigator.of(context).pushNamed('/Cliente', arguments: _cliente);
          }
        }
      });
      // print(json.encode(_producto));
      // setState(() => productoSemana.add(_producto));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  // Future<void> listenProductosSemana() async {
  //   // await iniciarNotificaciones();
  //   final Stream<Producto> stream = await obtenerProductosSemana();
  //   stream.listen((Producto _producto) {
  //     setState(() {
  //       if (currentUser.value.apiToken == null) {
  //         Navigator.of(context).pushNamed('/Login');
  //       }
  //     });
  //     // print(json.encode(_producto));
  //     setState(() => productoSemana.add(_producto));
  //   }, onError: (a) {
  //     print(a);
  //   }, onDone: () {});
  // }

  // void requestForCurrentLocation(BuildContext context) {
  //   OverlayEntry loader = Helper.overlayLoader(context);
  //   Overlay.of(context).insert(loader);
  //   setCurrentLocation().then((_address) async {
  //     deliveryAddress.value = _address;
  //     await refreshHome();
  //     loader.remove();
  //   }).catchError((e) {
  //     loader.remove();
  //   });
  // }

  // Future<void> refreshHome() async {
  //   setState(() {
  //     productoSemana = <Producto>[];
  //     // trendingProducts = <Product>[];
  //     // categories = <Category>[];
  //     // brands = <Brand>[];
  //     //topStores = <Store>[];
  //     //popularStores = <Store>[];
  //     //recentReviews = <Review>[];
  //   });
  //   // await listenForTrendingProducts();
  //   // await listenForCategories();
  //   // await listenForBrands();
  //   await listenProductosSemana();
  // }
}
