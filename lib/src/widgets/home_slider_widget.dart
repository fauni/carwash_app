import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:photo_view/photo_view.dart';
import 'package:carwash/src/controllers/slider_controller.dart';
import '../../src/helpers/app_config.dart' as config;
import 'package:flutter/material.dart';

import 'cards_carousel_loader_widget.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends StateMVC<HomeSliderWidget> {
  int _current = 0;
  late SliderController _con;
  _HomeSliderWidgetState() : super(SliderController()) {
    _con = controller as SliderController;
  }

  @override
  void initState() {
    // TODO: implement initState
    _con.cargarPublicidad(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
//      fit: StackFit.expand,
      children: <Widget>[
        _con.publicidades.isEmpty
            ? const CardsCarouselLoaderWidget()
            : CarouselSlider(
                options: CarouselOptions(
                  height: 500,
                  scrollDirection: Axis.vertical,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, pagechange) {
                    setState(() {
                      _current = index.toInt();
                    });
                  },
                ),
                items: _con.publicidades.map((publicidad) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DetailScreen(
                                  heroTag: '${publicidad.idPublicidad}',
                                  image:
                                      'https://procarewashing.com/apicwash/assets/imagenes_publicidad/${publicidad.urlPublicacion}',
                                );
                              }));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              height: 380,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://procarewashing.com/apicwash/assets/imagenes_publicidad/${publicidad.urlPublicacion}',
                                  ), // NetworkImage(slide.image.url,),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.2),
                                      offset: Offset(0, 4),
                                      blurRadius: 9)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              width: config.App(context).appWidth(45),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    '', //publicidad.detallePublicidad,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(TextStyle(height: 1)),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                    },
                  );
                }).toList(),
              ),
        Positioned(
          bottom: 25,
          right: 41,
          left: 41,
//          width: config.App(context).appWidth(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _con.sliders.map((slide) {
              return Container(
                width: 20.0,
                height: 3.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == _con.sliders.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
//          width: config.App(context).appWidth(100),
          child: OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close),
            textColor: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? heroTag;

  const DetailScreen({Key? key, this.image, this.heroTag}) : super(key: key);

  @override
  _DetailScreenWidgetState createState() => _DetailScreenWidgetState();
}

class _DetailScreenWidgetState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        child: Hero(
            tag: widget.heroTag!,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.image!),
            )),
      ),
    ));
  }
}
