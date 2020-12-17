import 'package:dynamic_theme/dynamic_theme.dart';
import '../../src/helpers/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/i18n.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.transparent.withOpacity(0.5),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                currentUser.value.apiToken != null
                    ? Navigator.of(context).pushNamed('/Pages', arguments: 1)
                    : Navigator.of(context).pushNamed('/Login');
              },
              child: currentUser.value.apiToken == null
                  ? UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.1),
                      ),
                      accountName: Text(
                        'Favio Duran',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      accountEmail: Text(
                        'favio.duran@gmail.com',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7HRr0tmPAYWeeNS2tgW_PCLxH6gQ8yMZlGg&usqp=CAU'),
                        // NetworkImage(currentUser.value.image.thumb),
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
                            S.of(context).guest,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 2);
              },
              leading: Icon(
                UiIcons.home,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                'Inicio',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 0);
              },
              leading: Icon(
                UiIcons.bell,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                'Mis Reservas',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Vehiculo', arguments: 3);
              },
              leading: Icon(
                UiIcons.inbox,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                'Mis Autos',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 4);
              },
              leading: Icon(
                UiIcons.heart,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                'Contáctanos',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/Categories');
            //   },
            //   leading: Icon(
            //     UiIcons.folder_1,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     'Cerrar Sesión',
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            // ListTile(
            //   dense: true,
            //   title: Text(
            //     S.of(context).application_preferences,
            //     style: Theme.of(context).textTheme.body1,
            //   ),
            //   trailing: Icon(
            //     Icons.remove,
            //     color: Theme.of(context).focusColor.withOpacity(0.3),
            //   ),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/Help');
            //   },
            //   leading: Icon(
            //     UiIcons.information,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     S.of(context).help__support,
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            // ListTile(
            //   onTap: () {
            //     if (currentUser.value.apiToken != null) {
            //       Navigator.of(context).pushNamed('/Settings');
            //     } else {
            //       Navigator.of(context).pushReplacementNamed('/Login');
            //     }
            //   },
            //   leading: Icon(
            //     UiIcons.settings_1,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     S.of(context).settings,
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/Languages');
            //   },
            //   leading: Icon(
            //     UiIcons.planet_earth,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     S.of(context).languages,
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            // ListTile(
            //   onTap: () {
            //     if (Theme.of(context).brightness == Brightness.dark) {
            //       setBrightness(Brightness.light);
            //       DynamicTheme.of(context).setBrightness(Brightness.light);
            //     } else {
            //       setBrightness(Brightness.dark);
            //       DynamicTheme.of(context).setBrightness(Brightness.dark);
            //     }
            //   },
            //   leading: Icon(
            //     Icons.brightness_6,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     Theme.of(context).brightness == Brightness.dark
            //         ? S.of(context).light_mode
            //         : S.of(context).dark_mode,
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  logout().then((value) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Pages', (Route<dynamic> route) => false,
                        arguments: 2);
                  });
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                currentUser.value.apiToken != null
                    ? S.of(context).log_out
                    : S.of(context).login,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            // currentUser.value.apiToken == null
            //     ? ListTile(
            //         onTap: () {
            //           Navigator.of(context).pushNamed('/SignUp');
            //         },
            //         leading: Icon(
            //           Icons.person_add,
            //           color: Theme.of(context).focusColor.withOpacity(1),
            //         ),
            //         title: Text(
            //           S.of(context).register,
            //           style: Theme.of(context).textTheme.subhead,
            //         ),
            //       )
            //     : SizedBox(height: 0),
            // setting.value.enableVersion
            //     ? ListTile(
            //         dense: true,
            //         title: Text(
            //           S.of(context).version + " " + setting.value.appVersion,
            //           style: Theme.of(context).textTheme.body1,
            //         ),
            //         trailing: Icon(
            //           Icons.remove,
            //           color: Theme.of(context).focusColor.withOpacity(0.3),
            //         ),
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
