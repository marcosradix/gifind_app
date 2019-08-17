
import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:sprintf/sprintf.dart';

var requestApi = "https://api.giphy.com/v1/gifs/trending?api_key=URGfFwLD5ceVGZljJK9NEY9ag89hJwl3&limit=20&rating=G";
class GifService {
Future<Map>  getGifs({String search, int offset = 0}) async {
http.Response response;
if(search == null){
    response = await http.get(requestApi);
}else{
  requestApi = sprintf("https://api.giphy.com/v1/gifs/search?api_key=URGfFwLD5ceVGZljJK9NEY9ag89hJwl3&q=%s&limit=25&offset=%d&rating=G&lang=pt", [search, offset]);
  response = await http.get(requestApi);
}
   
  return json.decode( response.body );
}

    void onImageShared( Map gifData) async {
      var request = await HttpClient().getUrl(Uri.parse(gifData['images']['fixed_height']['url']));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(gifData['title'], 'gifind.jpg', bytes, 'image/jpg');
    }

}