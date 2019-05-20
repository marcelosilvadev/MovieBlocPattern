import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

/*
  Dentro da classe MoviesBloc estamos criando o objeto da classe 
  "Repository" que será usado para acessar o fetchAllMovies().
*/

class MoviesBloc {
  final _repository = Repository();

  /*
    Estamos criando um objeto PublishSubject cuja responsabilidade é 
    adicionar os dados que obteve do servidor na forma de objeto ItemModel 
    e passá-lo para a tela da interface do usuário como fluxo. Para passar 
    o objeto ItemModel como fluxo, criamos outro método allMovies()cujo tipo 
    de retorno é Observable;
  */
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
/*
Estamos criando o objeto de bloco. Desta forma, estamos dando 
acesso a uma única instância da classe MoviesBloc para a tela 
da interface do usuário.
 */