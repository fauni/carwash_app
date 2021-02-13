import 'dart:async';
import 'dart:io';

// import 'package:applafarmobile/src/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProviders {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensaje => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print(
          "======================== OBTENER TOKEN ==============================");
      print(token);
      // guardarTokenDevice(token);
      // dDa8fMekTi-CCAKndtBXlC:APA91bHlUXJ75OuHaJ6IqQ1XPQF32W5qwiVPrbKUvnuPL0w-zFEXu1cujis0rIVGENko50zS_aSjnj0DEpm3EWhOlLqA_2Hz3DhJwhYB-iy-UovXMjuUL2walYficzHQCr5qYPOAU3dk      Simulador Nexus 5
      // eyFxaWFaT4OUC_ojuHVwrz:APA91bFC1b_7z3qIAAsG9p_Icod9lBYLUHKiWcZdL9MXTdcqDYvwSKcFf_nTx_QXK3eQUqacOvncNV9v2_Z3aTQgtKUWe1fTEQBDfl_OTSN_YEZpwxq_pcMgDyh3fiSqzGEaGxOc41qj      SMA20
      // fhrcJlLJQ5i_VF4NUYpSTw:APA91bHkK9pJLbD7_xoAeX7u_bNmGMhKMKQNyk5cMTiqgKKvgCcworhqMut-CeKtC0IZeVtim7A7f8UdMmWb4TMr6BId1asIrMrj2NPoEBuQ_XHq260jZtlutEMLozWAL4OnoPYWh6RM
    });

    _firebaseMessaging.configure(
      onMessage: (info) {
        print('===================== On Message ====================');
        print(info);

        // String argumento = 'no-data';
        // if (Platform.isAndroid) {
        //   argumento = info['data'] ?? 'no-data';
        // }
        String argumento = info['data']['id'];
        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (info) {
        print('===================== On Launch ====================');
        print(info);
      },
      onResume: (info) {
        print('===================== On Resume ====================');
        print(info);

        String argumento = info['data']['id'];
        _mensajesStreamController.sink.add(argumento);
      },
    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
