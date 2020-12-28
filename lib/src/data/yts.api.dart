import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:movie_list_redux/src/models/index.dart';

class YtsApi {
  const YtsApi({@required Client client})
      : assert(client != null),
        _client = client;

  final Client _client;

  Future<List<Movie>> getMovies(int page, String quality, List<String> genres, String orderBy) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
      queryParameters: <String, String>{
        'limit': '6',
        'page': '$page',
        'order_by': orderBy,
        if (quality != null) 'quality': quality,
        if (genres.isNotEmpty) 'genre': genres.join(','),
      },
    );
    final Response response = await _client.get(url);
    final List<dynamic> data = jsonDecode(response.body)['data']['movies'] as List<dynamic>;
    return data.map((dynamic json) => Movie.fromJson(json)).toList();
  }
}
