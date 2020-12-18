import 'package:flutter/cupertino.dart';
import 'package:movie_list_redux/src/actions/get_movies.dart';
import 'package:movie_list_redux/src/data/yts.api.dart';
import 'package:movie_list_redux/src/models/app_state.dart';
import 'package:movie_list_redux/src/models/movie.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

class AppMiddleware {
  AppMiddleware({@required YtsApi ytsApi})
      : assert(ytsApi != null),
        _ytsApi = ytsApi;

  final YtsApi _ytsApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      _getMoviesMiddleware,
    ];
  }

  Future<void> _getMoviesMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is! GetMovies) {
      return;
    }

    try {
      final List<Movie> movies = await _ytsApi.getMovies();
      final GetMoviesSuccessful successful = GetMoviesSuccessful(movies);
      store.dispatch(successful);
    } catch (e) {
      final GetMovieError error = GetMovieError(e);
      store.dispatch(error);
    }
  }
}
