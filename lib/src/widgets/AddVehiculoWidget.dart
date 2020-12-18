import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AddVehiculoWidget extends StatefulWidget {
  @override
  _AddVehiculoWidgetState createState() => _AddVehiculoWidgetState();
}

class _AddVehiculoWidgetState extends State<AddVehiculoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Agregar un auto nuevo'),
        leading: new IconButton(
          icon: new Icon(Icons.clear, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).accentColor)),

              height: 150, //MediaQuery.of(context).size.height / 3,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.camera_alt),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Divider(),
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: [
                "Brazil",
                "Italia",
                "Tunisia",
                'Canada',
                'Bolivia',
                'EEUU'
              ],
              label: "Seleccionar Fabricante",
              onChanged: print,
              selectedItem: "Brazil",
              showSearchBox: true,
              dropdownSearchDecoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 0.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0),
                ),
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
              ),
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Buscar Fabricante",
              ),
              popupTitle: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Fabricante',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              popupShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
