import 'package:carwash/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
