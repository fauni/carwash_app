import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetSwitch extends StatefulWidget {
  BottomSheetSwitch({@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: 'http://intranet.lafar.net/images/rav4.jpg',
              imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  )),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text('Wolkswagen Gol GT 200'),
            subtitle: Text('Wolkswagen'),
          ),
          Divider(),
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: 'http://intranet.lafar.net/images/sentra.jpg',
              imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  )),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text('Nissan Sentra 2 2021'),
            subtitle: Text('Nissan'),
          ),
          Divider(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 1.0),
            ),
            child: ListTile(
              leading: Icon(
                Icons.add,
                color: Theme.of(context).hintColor,
                size: 50,
              ),
              title: Text('Agregar un auto nuevo'),
              subtitle: Text('Nueva Movilidad'),
              onTap: () {
                print('Agregar nuevo carro -------');
              },
            ),
          ),
        ],
      ),
    );
  }
}
