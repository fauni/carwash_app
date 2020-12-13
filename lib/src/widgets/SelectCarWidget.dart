import '../../generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'CarItemWidget.dart';

class SelectCarWidget extends StatefulWidget {
  // User user;
  VoidCallback onChanged;

  SelectCarWidget({Key key, this.onChanged}) : super(key: key);

  @override
  _SelectCarWidgetState createState() => _SelectCarWidgetState();
}

class _SelectCarWidgetState extends State<SelectCarWidget> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          // barrierColor: Colors.black.withAlpha(1),
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.only(
                  top: 15.0, left: 35.0, right: 35.0, bottom: 15.0),
              padding: EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 15.0, bottom: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Theme.of(context).secondaryHeaderColor),
              ),
              height: MediaQuery.of(context).size.height,
              child: Text('Hola'),
            );
          },
        );
      },
      child: Text(
        S.of(context).edit,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      Navigator.pop(context);
    }
  }
}
