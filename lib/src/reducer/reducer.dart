import 'package:movie_list_redux/src/actions/get_movies.dart';
import 'package:movie_list_redux/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is GetMoviesSuccessful) {
    final AppStateBuilder builder = state.toBuilder();
    builder.movies.addAll(action.movies);
    return builder.build();
  }
  return state;
}
