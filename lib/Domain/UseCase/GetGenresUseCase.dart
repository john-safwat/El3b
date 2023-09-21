import 'package:El3b/Data/Repository/GenresRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Genres/Genre.dart';
import 'package:El3b/Domain/Repository/GenresRepository.dart';


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