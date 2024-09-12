import 'package:data/Repository/genres_repository_impl.dart';
import 'package:domain/Models/Genres/genre.dart';
import 'package:domain/Repository/genres_repository.dart';


// dependency injection
GetGenresUseCase injectGetGenresUseCase(){
  return GetGenresUseCase(repository: injectGenresRepository());
}


class GetGenresUseCase {

  GenresRepository repository;
  GetGenresUseCase ({required this.repository});

  Future<List<Genre>> invoke()async{
    var response = await repository.getGenres();
    return response??[];
  }

}