

import 'package:flutter/material.dart';
import 'package:movie_list_redux/src/containers/movies.container.dart';
import 'package:movie_list_redux/src/models/movie.dart';


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
    return MoviesContainer(
      builder: (BuildContext context, List<Movie> movies) {
        return Scaffold(
          appBar: AppBar(),
          body: Builder(
            builder: (BuildContext context) {
              return GridView.builder(
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
              );
            },
          ),
        );
      },
    );
  }
}
