import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  // LoginController _con;

  // _DrawerWidgetState() : super(LoginController()) {
  //   _con = controller;
  // }

  @override
  void initState() {
    // _con.obtenerUsuario();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.transparent.withOpacity(0.5),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                currentUser!.value.uid != null
                    //? Navigator.of(context).pushNamed('/Pages', arguments: 1)
                    ? Navigator.of(context).pushNamed('/Main', arguments: 1)
                    : Navigator.of(context).pushNamed('/Login');
              },
              child: currentUser!.value.uid != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 25, top: 35),
                      child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.1),
                        ),
                        accountName: Text(''),
                        // accountName: Text(
                        //   currentUser.value.displayName,
                        //   style: Theme.of(context).textTheme.subtitle1,
                        // ),
                        accountEmail: Text(
                          currentUser!.value.email!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        currentAccountPicture: CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            backgroundImage: currentUser!.value.photoUrl == null
                                ? AssetImage('assets/img/auto_default.PNG')
                                : AssetImage('assets/img/auto_default.PNG')
                            /*currentUser.value.photoUrl.length > 0
                                    ? NetworkImage(currentUser.value.photoUrl)
                                    : AssetImage('assets/img/auto_default.PNG')*/
                            // NetworkImage(currentUser.value.image.thumb),
                            ),
                      ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            size: 32,
                            color: Theme.of(context).accentColor.withOpacity(1),
                          ),
                          SizedBox(width: 30),
                          Text(
                            'Guest',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).pushNamed('/Pages', arguments: 2);
                Navigator.of(context).pushNamed('/Main', arguments: 2);
              },
              leading: Image.asset('assets/img/inicio_blue.png'),
              title: Text(
                'Inicio',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Reservas', arguments: 0);
              },
              leading: Image.asset('assets/img/mis_reservas_blue.png'),
              title: Text(
                'Mis Reservas',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Vehiculo', arguments: 3);
              },
              leading: Image.asset('assets/img/mis_autos_blue.png'),
              title: Text(
                'Mis Vehículos',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Contactanos');
              },
              leading: Image.asset('assets/img/contactanos_blue.png'),
              title: Text(
                'Contáctanos',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            ListTile(
              onTap: () {
                if (currentUser!.value.verifyEmail != null) {
                  // _con.googleSignOut();
                  logout().then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Login', (Route<dynamic> route) => false);
                  });
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              leading: Image.asset('assets/img/cerrar_sesion_blue.png'),
              title: Text(
                currentUser!.value.verifyEmail != null
                    ? 'Cerrar Sesión'
                    : 'Login',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
