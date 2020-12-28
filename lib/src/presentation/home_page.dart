import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_redux/src/actions/index.dart';
import 'package:movie_list_redux/src/containers/index.dart';
import 'package:movie_list_redux/src/models/index.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsLoadingContainer(
      builder: (BuildContext context, bool isLoading) {
        return MoviesContainer(
          builder: (BuildContext context, List<Movie> movies) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Movie List by Iura'),
                actions: <Widget>[
                  OrderByContainer(
                    builder: (BuildContext context, String orderBy) {
                      return IconButton(
                        icon: Icon(orderBy == 'desc' ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                        onPressed: () {
                          final Store<AppState> store = StoreProvider.of<AppState>(context);

                          if (orderBy == 'desc') {
                            store.dispatch(const SetOrderBy('asc'));
                          } else {
                            store.dispatch(const SetOrderBy('desc'));
                          }
                          store.dispatch(const GetMovies.start(1));
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Builder(
                builder: (BuildContext context) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: <Widget>[
                      GenreContainer(
                        builder: (BuildContext context, List<String> genres) {
                          return Wrap(
                            spacing: 8.0,
                            children: <String>[
                              'Comedy',
                              'Sci-Fi',
                              'Horror',
                              'Romance',
                              'Action',
                              'Thriller',
                              'Drama',
                              'Mystery',
                              'Crime',
                              'Animation',
                              'Adventure',
                              'Fantasy',
                              'Comedy-Romance',
                              'Action-Comedy',
                              'Superhero',
                            ].map((String genre) {
                              return ChoiceChip(
                                label: Text(genre),
                                selected: genres.contains(genre),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    StoreProvider.of<AppState>(context)
                                      ..dispatch(SetGenres(<String>[genre]))
                                      ..dispatch(const GetMoviesStart(1));
                                  } else {
                                    StoreProvider.of<AppState>(context)
                                      ..dispatch(const SetGenres(<String>[]))
                                      ..dispatch(const GetMoviesStart(1));
                                  }
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                      QualityContainer(
                        builder: (BuildContext context, String quality) {
                          return DropdownButton<String>(
                            value: quality,
                            hint: const Text('All'),
                            onChanged: (String value) {
                              StoreProvider.of<AppState>(context)
                                ..dispatch(SetQuality(value))
                                ..dispatch(const GetMoviesStart(1));
                            },
                            items: <String>[null, '720p', '1080p', '2160p', '3d'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value ?? 'All'),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            crossAxisCount: 3,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Movie movie = movies[index];

                            return GridTile(
                              child: Image.network(movie.mediumCoverImage),
                              footer: GridTileBar(
                                title: Text(movie.title),
                                subtitle: Text(movie.genres.join(', ')),
                              ),
                            );
                          },
                        ),
                      ),
                      FlatButton(
                        child: const Text('Load more'),
                        onPressed: () {
                          final Store<AppState> store = StoreProvider.of<AppState>(context);
                          store.dispatch(GetMovies.start(store.state.page));
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
