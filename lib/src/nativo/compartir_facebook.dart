import 'package:flutter/services.dart';

class CompartirFacebook {
  final MethodChannel _methodChannel =
      MethodChannel("app.gghh/share_platform_channel");

  Future<void> version() async {
    final result = await _methodChannel.invokeMethod("version");
    print("$result");
  }
}
