import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = env["API_KEY"];
  String _url = env["API_URL"];
  String _languaje = env["LANGUAGE"];

  int _popularesPage = 0;
  bool _cargando = false;

  PeliculasProvider(){
    this.getPopulares();
  }

  List<Pelicula> _populares = [];

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void  disposeStreams(){
    _popularesStreamController?.close();
  }

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
    if(_cargando){
      return [];
    }
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apikey,
      'language': _languaje,
      'page': _popularesPage.toString()
    });

    final response = await _procesarRespuesta(url);
    _populares.addAll(response);

    popularesSink(_populares);
    _cargando = false;
    return response;
  }

  Future<List<ActorModel>> getCast(int peliculaId) async {
    final url = Uri.https(this._url, "3/movie/$peliculaId/credits", {
      'api_key': _apikey,
      'language': _languaje
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final reparto = Reparto.fromJsonList(decodedData["cast"]);
    
    return reparto.actores;
  }
}