import 'package:carwash/src/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends StateMVC<SplashPage> {
  SplashPageController _con;

  SplashPageState() : super(SplashPageController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    int numero = 0;
    // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
        numero++;
      });
      if (progress == 100) {
        try {
          // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          //Navigator.of(context).pushReplacementNamed('/Pages');
          Navigator.of(context).pushReplacementNamed('/Main');
        } catch (e) {}
      }
      if (progress == 41 && numero == 4) {
        try {
          // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          Navigator.of(context).pushReplacementNamed('/Login');
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/img/fondo_car.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Tu auto, nuestro cuidado',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Theme.of(context).secondaryHeaderColor),
                // color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/isotipo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).secondaryHeaderColor)
                    // Colors.white),
                    ),
              ],
            ),
          ],
        ),
        // child: Center(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Image.asset(
        //         'assets/img/fondo_car.png',
        //         width: 150,
        //         fit: BoxFit.cover,
        //       ),
        //       SizedBox(height: 50),
        //       CircularProgressIndicator(
        //         valueColor:
        //             AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
