import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailNetworkScreen extends StatefulWidget {
  final String image;
  final String heroTag;

  const DetailNetworkScreen({Key key, this.image, this.heroTag})
      : super(key: key);

  @override
  _DetailNetworkScreenWidgetState createState() =>
      _DetailNetworkScreenWidgetState();
}

class _DetailNetworkScreenWidgetState extends State<DetailNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context))
          ],
        ),
        body: Center(
          child: GestureDetector(
            child: Hero(
              tag: widget.heroTag,
              child: PhotoView(
                imageProvider: NetworkImage(widget.image),
                // imageProvider: CachedNetworkImageProvider(widget.image),
                //imageProvider:
              ),
            ),
          ),
        ));
  }
}
