import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_list_redux/src/models/movie.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class YtsApi {
  const YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies() async {
    final Response response =
        await _client.get('https://yts.mx/api/v2/list_movies.json?limit=50');
    final List<dynamic> data =
        jsonDecode(response.body)['data']['movies'] as List<dynamic>;
    return data.map((dynamic json) => Movie.fromJson(json)).toList();
  }
}
