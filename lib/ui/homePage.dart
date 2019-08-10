import 'package:flutter/material.dart';
import 'package:gifind_app/services/gifService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var gifService = GifService();

  _getGifs({String valueType}) async {
    return await gifService.getGifs();
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((data) {
      print(data);
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
                              "Ocorreu um erro inesperado.",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _createGitTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createGitTable(BuildContext context, AsyncSnapshot snapshot) {
    return Text(
      "Tudo certo por aqui.",
      style: TextStyle(color: Colors.white),
    );
  }
}
