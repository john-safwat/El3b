import 'package:data/Repository/GenresRepositoryImpl.dart';
import 'package:domain/Models/Genres/Genre.dart';
import 'package:domain/Repository/GenresRepository.dart';


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