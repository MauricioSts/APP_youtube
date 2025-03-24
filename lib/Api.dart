import 'package:app_youtube/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const CHAVE_YOUTUBE_API = "AIzaSyDLPkI16FU8FrC5_SOQldS30Nvof2B5-eU";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "www.googleapis.com"; // Mudei a URL para completa em URI.https

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    try {
      final uri = Uri.https(URL_BASE, "/youtube/v3/search", {
        "part": "snippet", // Especifica as informações que queremos da API
        "type": "video",
        "maxResults": "20",
        "order": "date",
        "key": CHAVE_YOUTUBE_API,

        "q": pesquisa,
      });

      http.Response response = await http.get(uri); // Realiza a requisição

      if (response.statusCode == 200) {
        Map<String, dynamic> dadosJson = json.decode(
          response.body,
        ); // Converte a resposta da API em JSON

        // Cria a lista de objetos Video a partir dos dados retornados pela API
        List<Video> videos =
            (dadosJson["items"] as List).map<Video>((map) {
              return Video.fromJson(
                map,
              ); // Converte cada item em um objeto Video
            }).toList();

        return videos;
      } else {
        // Caso a resposta não seja 200 OK, retorna uma lista vazia
        print("Erro na requisição. Código: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // Caso ocorra algum erro (ex: falha de rede), retorna uma lista vazia
      print("Erro ao fazer a requisição: $e");
      return [];
    }
  }
}
