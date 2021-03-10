import 'package:carwash/src/pages/slider_page.dart';
import 'package:flutter/material.dart';

class IndicatorPage extends StatefulWidget {
  IndicatorPage({Key key}) : super(key: key);

  @override
  IndicatorPageState createState() => IndicatorPageState();
}

class IndicatorPageState extends State<IndicatorPage> {
  int _currentPage = 0;

  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "Paso 1",
        description: "Agrega y Selecciona tu vehículo",
        image: "assets/img/Paso1.png"),
    SliderPage(
        title: "Paso 2",
        description: "Selecciona el servicio que requiere tu vehiculo",
        image: "assets/img/Paso2.png"),
    SliderPage(
        title: "Paso 3",
        description: "Selecciona el día y la hora del servicio",
        image: "assets/img/Paso3.png"),
    SliderPage(
        title: "¡Fantástico!",
        description: "Ahora sí, tu auto, nuestro cuidado",
        image: "assets/img/Fantastico.png"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.5)));
                  })),
              InkWell(
                onTap: () {
                  if (_currentPage == (_pages.length - 1)) {
                    Navigator.pop(context);
                  } else {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint);
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 300),
                  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(35)),
                  child: (_currentPage == (_pages.length - 1))
                      ? Text(
                          "Realizar mi Reserva",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      : Icon(
                          Icons.navigate_next,
                          size: 50,
                          color: Colors.white,
                        ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
