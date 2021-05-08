import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = env["API_KEY"];
  String _url = env["API_URL"];
  String _languaje = env["LANGUAGE"];

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final peliculas = Peliculas.fromJsonList(decodedData["results"]);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      'api_key': _apikey,
      'language': _languaje
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apikey,
      'language': _languaje
    });
  
    return await _procesarRespuesta(url);
  }
}