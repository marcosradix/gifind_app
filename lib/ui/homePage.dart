import 'package:flutter/material.dart';
import 'package:gifind_app/services/gifService.dart';
import 'package:gifind_app/ui/gifDetailPage.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var gifService = GifService();

  String _search;
  int _offset = 0;
  _getGifs() async {
    return await gifService.getGifs(search: _search, offset: _offset);
  }

  @override
  void initState() {
    super.initState();
     _getGifs().then((data) {
      //print(_updateScreeen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Pesquise aqui seu gif",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (String text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                    break;
                  default:
                    return snapshot.hasError
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Ocorreu um erro inesperado. "+snapshot.error.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _createGifTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    }
    return data.length + 1;
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: _getCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data["data"].length) {
          return SizedBox(
      width: 200,
      child: Hero(
        tag: index,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){
              navigateToSubPage(snapshot, context, index);
              },
            child: FadeInImage.memoryNetwork(
              key: Key(new DateTime.now().millisecondsSinceEpoch.toString() +
              snapshot.data['data'][index]['images']['fixed_height']['mp4_size']),
              image: snapshot.data['data'][index]['images']['fixed_height']['url'], 
              placeholder: kTransparentImage,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onLongPress: (){
            Share.share(
              snapshot.data['data'][index]['images']['fixed_height']['url']
            );

            },
          ),
          ),
        ),
      );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70.0),
                  Text(
                    "Carregar mais..",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 24;
                });
              },
            ),
          );
        }
      },
    );
  }

  Future navigateToSubPage(AsyncSnapshot snapshot ,context, index) async {
  bool data = await Navigator.push(context, MaterialPageRoute( builder: (context) => GifDetailPage(gifData:snapshot.data['data'][index])  ) );
    print( data);
}
}
