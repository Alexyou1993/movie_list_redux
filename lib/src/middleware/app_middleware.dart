import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_list_redux/src/actions/get_movies.dart';
import 'package:movie_list_redux/src/data/yts.api.dart';
import 'package:movie_list_redux/src/models/app_state.dart';
import 'package:movie_list_redux/src/models/movie.dart';
import 'package:redux/redux.dart';

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
    if (action is! GetMoviesStart) {
      return;
    }

    try {
      final GetMoviesStart startAction = action as GetMoviesStart;
      final List<Movie> movies = await _ytsApi.getMovies(
        startAction.page,
        store.state.quality,
        store.state.genres.asList(),
        store.state.orderBy,
      );
      final GetMovies successful = GetMovies.successful(movies);
      store.dispatch(successful);
    } catch (e) {
      final GetMovies error = GetMovies.error(e);
      store.dispatch(error);
    }
  }
}
