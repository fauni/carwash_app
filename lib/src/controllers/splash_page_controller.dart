import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/i18n.dart';
// import '../repository/settings_repository.dart' as settingRepo;
// import '../repository/user_repository.dart' as userRepo;

class SplashPageController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  SplashPageController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }
  @override
  void initState() {
    super.initState();
    progress.value["Setting"] = 41;
    progress?.notifyListeners();
    progress.value["User"] = 59;
    progress?.notifyListeners();
    // firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // configureFirebase(firebaseMessaging);
    // settingRepo.setting.addListener(() {
    //   if (settingRepo.setting.value.appName != null &&
    //       settingRepo.setting.value.appName != '' &&
    //       settingRepo.setting.value.mainColor != null) {
    //     progress.value["Setting"] = 41;
    //     progress?.notifyListeners();
    //   }
    // });
    // userRepo.currentUser.addListener(() {
    //   if (userRepo.currentUser.value.auth != null) {
    //     progress.value["User"] = 59;
    //     progress?.notifyListeners();
    //   }
    // });
    Timer(Duration(seconds: 5), () {
      progress.value["Setting"] = 41;
      progress?.notifyListeners();
      progress.value["User"] = 59;
      progress?.notifyListeners();
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(''),
      ));
    });
  }

  // void configureFirebase(FirebaseMessaging _firebaseMessaging) {
  //   try {
  //     _firebaseMessaging.configure(
  //       onMessage: notificationOnMessage,
  //       onLaunch: notificationOnLaunch,
  //       onResume: notificationOnResume,
  //     );
  //   } catch (e) {
  //     print(CustomTrace(StackTrace.current, message: 'Error Config firebase')
  //         .toString());
  //   }
  // }

  // Future notificationOnResume(Map<String, dynamic> message) async {
  //   print(message['data']['id']);
  //   try {
  //     if (message['data']['id'] == "orders") {
  //       settingRepo.navigatorKey.currentState
  //           .pushReplacementNamed('/Pages', arguments: 3);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future notificationOnLaunch(Map<String, dynamic> message) async {
  //   String messageId = await settingRepo.getMessageId();
  //   try {
  //     if (messageId != message['google.message_id']) {
  //       if (message['data']['id'] == "orders") {
  //         await settingRepo.saveMessageId(message['google.message_id']);
  //         settingRepo.navigatorKey.currentState
  //             .pushReplacementNamed('/Pages', arguments: 3);
  //       }
  //     }
  //   } catch (e) {}
  // }

  // Future notificationOnMessage(Map<String, dynamic> message) async {
  //   Fluttertoast.showToast(
  //     msg: message['notification']['title'],
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.TOP,
  //     timeInSecForIosWeb: 5,
  //   );
  // }
}
