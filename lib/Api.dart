import 'package:app_youtube/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const CHAVE_YOUTUBE_API = "AIzaSyDLPkI16FU8FrC5_SOQldS30Nvof2B5-eU";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "www.googleapis.com";

class Api {
  pesquisar(String pesquisa) async {
    final uri = Uri.https(URL_BASE, "/youtube/v3/search", {
      "part": "snippet",
      "type": "video",
      "maxResults": "20",
      "order": "date",
      "key": CHAVE_YOUTUBE_API,
      "channelId": ID_CANAL,
      "q": pesquisa,
    });

    http.Response response = await http.get(uri);

    Map<String, dynamic> dadosJson = json.decode(response.body);

    List<Video> videos =
        dadosJson["items"].map<Video>((map) {
          return Video.fromJson(map);
          //return Video.converterJson(map);
        }).toList();

    for (var video in videos) {
      print("resultado " + video.titulo);
    }

    /*for (var video in dadosJson["items"]) {
      print("resultado" + video.toString());
    }*/

    //print("resultado: " + dadosJson["items"].toString());
  }
}
