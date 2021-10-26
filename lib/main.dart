// import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/route_generator.dart';
// import 'package:global_configuration/global_configuration.dart';
import 'package:carwash/src/models/setting.dart';
import 'package:carwash/src/services/push_notifications_service.dart';
// import 'package:pcw_admin/src/route_generator.dart';
// import 'package:pcw_admin/src/theme.dart';

import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GlobalConfiguration().loadFromAsset('configurations');
  await PushNotificationService.initializaApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default initialized and error state to false
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    // initializeFlutterFire();
    super.initState();
    settingRepo.initSettings();
    userRepo.getCurrentUser();

    PushNotificationService.messagesStream.listen((message) {
      print('ProcareWashing MyApp: $message');

      navigatorKey.currentState?.pushNamed('/Compartir', arguments: message);
      // final snackBar = SnackBar(content: Text('$message'));
      // messengerKey.currentState!.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return MaterialApp(
            title: 'ProcareWashing',
            initialRoute: '/Splash',
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: messengerKey,
            theme: ThemeData(
              fontFamily: 'Scanno',
              primaryColor: const Color(0xFF2e3092),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  elevation: 0, foregroundColor: Colors.white),
              bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.black.withOpacity(0.8)),
              dialogTheme: DialogTheme(
                backgroundColor: Colors.black.withOpacity(0.8),
              ),
              primarySwatch: Colors.blue,
              // brightness: brightness,
              scaffoldBackgroundColor: Colors.transparent.withOpacity(1),
              accentColor: const Color(0xFF83bae5),
              dividerColor: const Color(0xFF409cd0),
              focusColor: const Color(0xFF3e87b7),
              hintColor: Colors.white, //Color(0xFF409cd0),
              textTheme: const TextTheme(
                bodyText1: TextStyle(fontSize: 14.0, color: Color(0xFF2e3092)),
                bodyText2: TextStyle(fontSize: 14.0, color: Color(0xFF409cd0)),
                button: TextStyle(fontSize: 14.0, color: Color(0xFF409cd0)),
                subtitle1: TextStyle(fontSize: 16.0, color: Color(0xFF409cd0)),
                subtitle2: TextStyle(fontSize: 16.0, color: Color(0xFF409cd0)),
                overline: TextStyle(fontSize: 16.0, color: Color(0xFF409cd0)),
                caption: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF83bae5)),
              ),
            ),
          );
        });
  }
}
