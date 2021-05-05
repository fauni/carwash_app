import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class EnVivoPage extends StatefulWidget {
  @override
  _EnVivoPageState createState() => _EnVivoPageState();
}

class _EnVivoPageState extends State<EnVivoPage> {
  VlcPlayerController _videoPlayerController;
  Future<void> initializePlayer() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      'rtsp://procare:procare...@190.104.10.52:554/cam/realmonitor?channel=4&subtype=0',
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    // await _videoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
