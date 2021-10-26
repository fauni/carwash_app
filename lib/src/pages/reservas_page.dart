//import 'package:cached_network_image/cached_network_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/src/controllers/reserva_controller.dart';
import 'package:carwash/src/models/route_argument.dart';
import 'package:carwash/src/pages/detalle_reserva_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReservasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReservasPageState();
  }
}

class ReservasPageState extends StateMVC<ReservasPage> {
  bool selected = false;
  late ReservaController _con;

  double? width_size;
  double? height_size;
  // bool _switchValue;

  ReservasPageState() : super(ReservaController()) {
    _con = controller as ReservaController;
  }
  @override
  void initState() {
    // _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Mis Reservas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Stack(children: [
        Image.asset(
          'assets/img/fondo_car.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(top: 100),
            child: Image.asset(
              'assets/img/isotipo.png',
              width: MediaQuery.of(context).size.width / 6,
            ),
          ),
        ),
        Container(
          width: width_size,
          height: height_size,
          padding: EdgeInsets.only(top: 200, bottom: 0),
          child: SingleChildScrollView(
            child: _con.reservasInner.isEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).accentColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/auto_on.png',
                          width: 100,
                        ),
                        Text(
                          'No encontramos reservas',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            _con.reservasInner.elementAt(index).estado == 'L'
                                ? Image.asset('assets/img/en_proceso_white.png')
                                : CachedNetworkImage(
                                    imageUrl: _con.rutaImg(
                                      _con.reservasInner.elementAt(index).foto!,
                                    ),
                                    /************* */
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                            width: 55.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            )),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                        title: Text(
                          _con.reservasInner.elementAt(index).placa!,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        subtitle: Text(
                          _con.reservasInner.elementAt(index).marca! +
                              ', ' +
                              _con.reservasInner.elementAt(index).modelo! +
                              '\n' +
                              _con.reservasInner
                                  .elementAt(index)
                                  .fechaReserva! +
                              ' ' +
                              _con.reservasInner.elementAt(index).horaReserva!,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.caretRight,
                          color: Theme.of(context).hintColor,
                        ),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetalleReservaPage(
                                      routeArgument: RouteArgument(
                                          id: _con.reservasInner
                                              .elementAt(index)
                                              .id,
                                          param: [
                                            _con.reservasInner.elementAt(index),
                                            'Detalle'
                                          ]),
                                    )),
                          );
                          _con.reservasInner = [];

                          if (result == null) {
                            setState(() {
                              _con.reservasInner = [];
                              _con.listarReservasInnerByIdCli();
                            });
                          }
                          // Navigator.of(context).pushNamed(
                          //   '/DetalleReserva',
                          //   arguments: new RouteArgument(
                          //       id: _con.reservasInner.elementAt(index).id,
                          //       param: [
                          //         _con.reservasInner.elementAt(index),
                          //         'Detalle'
                          //       ]),
                          // );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Theme.of(context).accentColor,
                        height: 15,
                      );
                    },
                    itemCount: _con.reservasInner.length,
                  ),
          ),
        )
      ]),
    );
  }
}
