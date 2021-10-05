import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_model.dart';

class ApiPopular{
  
  var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=1e3f5b8191b568930b860b51527012fa&language=es-MX&page=1');

  Future<List<PopularMoviesModel>?> getAllPopular() async {
    final response = await http.get(url);
    if( response.statusCode == 200){
      var popular =jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular = popular.map((movie) => PopularMoviesModel.fromJson(movie)).toList();
      return listPopular;
    }else{
      return null;
    }
  }
}