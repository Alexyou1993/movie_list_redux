import 'package:built_collection/built_collection.dart';
import 'package:movie_list_redux/src/actions/index.dart';
import 'package:movie_list_redux/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(
  <Reducer<AppState>>[
    TypedReducer<AppState, GetMoviesStart>(_getMoviesStart),
    TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
    TypedReducer<AppState, GetMoviesError>(_getMoviesErorr),
    TypedReducer<AppState, SetQuality>(_setQuality),
    TypedReducer<AppState, SetGenres>(_setGenres),
    TypedReducer<AppState, SetOrderBy>(_setOrderBy),
  ],
);

AppState _getMoviesStart(AppState state, GetMoviesStart action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    return b
      ..movies.addAll(action.movies)
      ..page = b.page + 1
      ..isLoading = false;
  });
}

AppState _getMoviesErorr(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = true);
}

AppState _setQuality(AppState state, SetQuality action) {
  return state.rebuild((AppStateBuilder b) {
    return b
      ..quality = action.quality
      ..movies.clear();
  });
}

AppState _setGenres(AppState state, SetGenres action) {
  return state.rebuild((AppStateBuilder b) {
    return b
      ..genres = ListBuilder<String>(action.genres)
      ..movies.clear();
  });
}

AppState _setOrderBy(AppState state, SetOrderBy action) {
  return state.rebuild((AppStateBuilder b) {
    return b
      ..orderBy = action.orderBy
      ..movies.clear();
  });
}
