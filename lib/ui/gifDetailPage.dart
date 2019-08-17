
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gifind_app/services/gifService.dart';
import 'package:swipedetector/swipedetector.dart';

class GifDetailPage extends StatelessWidget {
  final Map gifData;

  const GifDetailPage({Key key, this.gifData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  var gifService = GifService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(gifData['title']),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              gifService.onImageShared(gifData);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SwipeDetector(
          swipeConfiguration: SwipeConfiguration(
              verticalSwipeMinVelocity: 100.0,
              verticalSwipeMinDisplacement: 50.0,
              verticalSwipeMaxWidthThreshold: 100.0,
              horizontalSwipeMaxHeightThreshold: 50.0,
              horizontalSwipeMinDisplacement: 50.0,
              horizontalSwipeMinVelocity: 200.0),
          child: Hero(
            key: key,
            tag: gifData['title'],
            child: Image.network(gifData['images']['fixed_height']['url']),
          ),
          onSwipeDown: () {
            Navigator.pop(context, false);
          },
        ),
      ),
    );
  }
}
