import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

/*
  Classe MoviesBloc está passando os novos dados como stream. Então, para lidar com streams, 
  temos uma boa classe embutida, ou seja, StreamBuilder, que vai ouvir os fluxos de entrada 
  e atualizar a interface do usuário em conformidade. StreamBuilder está esperando um 
  streamparâmetro onde estamos passando o allMovies()método do MovieBloc como ele está 
  retornando um fluxo. Assim, no momento em que há um fluxo de dados chegando, o StreamBuilder 
  renderizará novamente o widget com os dados mais recentes. Aqui os dados da captura instantânea 
  estão segurando o objeto ItemModel.
 */

import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }

  openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data.results[index].title,
            posterUrl: data.results[index].backdrop_path,
            description: data.results[index].overview,
            releaseDate: data.results[index].release_date,
            voteAverage: data.results[index].vote_average.toString(),
            movieId: data.results[index].id,
          ),
        );
      }),
    );
  }
}
/*
  Há 10 anos, a interação com as páginas da Web era basicamente o envio de um formulário 
  longo para o backend e a execução de uma renderização simples no frontend. Os aplicativos 
  evoluíram para ser mais em tempo real: modificar um único campo de formulário pode disparar 
  automaticamente um salvamento no back-end, "curtir" alguns conteúdos pode ser refletido em 
  tempo real para outros usuários conectados e assim por diante.
 */