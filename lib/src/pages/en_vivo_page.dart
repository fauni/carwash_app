import 'dart:async';

import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/atencion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class EnVivoPage extends StatefulWidget {
  Atencion? atencion;

  EnVivoPage({Key? key, this.atencion}) : super(key: key);
  @override
  _EnVivoPageState createState() => _EnVivoPageState();
}

class _EnVivoPageState extends StateMVC<EnVivoPage> {
  late ReservaController _con;
  VlcPlayerController? _videoPlayerController;
  Future<void> initializePlayer() async {}

  _EnVivoPageState() : super(ReservaController()) {
    _con = controller as ReservaController;
  }

  @override
  void initState() {
    // startTimer();
    // TODO: implement initState
    super.initState();
    // _con.obtenerAtencionPorReserva(widget.reserva.id);
    print('=========== en vivoo =============');
    print(widget.atencion!.idReserva);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    _videoPlayerController = VlcPlayerController.network(
      widget.atencion!.rtsp!,
      hwAcc: HwAcc.FULL,
      // autoPlay: false,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([VlcAdvancedOptions.networkCaching(2000)]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(30),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    );
  }

  @override
  void dispose() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    super.dispose();
    await _videoPlayerController!.stopRendererScanning();
    // await _videoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(const Duration(seconds: 5), (t) {
    //   setState(() {
    //     showLoaderDialog(context);
    //   });
    //   t.cancel(); //stops the timer
    // });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Tu auto, nuestro cuidado'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController!,
          aspectRatio: 16 / 9,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
