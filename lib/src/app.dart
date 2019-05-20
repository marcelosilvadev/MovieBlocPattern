import 'package:flutter/material.dart';
import 'package:movie_bloc/src/ui/movie_list.dart';

//Classe pai da aplicação;
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MovieList(),
        ),
      );
  }
}