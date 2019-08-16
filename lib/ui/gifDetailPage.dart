import 'package:flutter/material.dart';

class GifDetailPage extends StatelessWidget {

final Map gifData;

  const GifDetailPage({Key key, this.gifData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
         title: Text(gifData['title']),
         backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gifData['images']['fixed_height']['url']),
      ),
    );
  }
}