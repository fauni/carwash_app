import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;

class SplashPageController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState>? scaffoldKey;

  SplashPageController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() {
    super.initState();
    settingRepo.setting.addListener(() {
      if (settingRepo.setting.value.appName != null &&
          settingRepo.setting.value.appName != '' &&
          settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 41;
        progress.notifyListeners();
      }
    });
    userRepo.currentUser!.addListener(() {
      if (userRepo.currentUser!.value.email != null) {
        progress.value["User"] = 59;
        progress.notifyListeners();
      }
    });
  }
}
