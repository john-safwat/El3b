import 'package:data/Repository/rawg_games_repository_impl.dart';
import 'package:domain/Models/Games/RAWG/rawg_game.dart';
import 'package:domain/Repository/rawg_games_repository.dart';

// dependency injection
AddGameToWishListUseCase injectAddGameToWishListUseCase(){
  return AddGameToWishListUseCase(repository: injectRAWGGamesRepository());
}

class AddGameToWishListUseCase {

  RAWGGamesRepository repository;
  AddGameToWishListUseCase({required this.repository});

  Future<int> invoke({required RAWGGame game , required String uid})async{
    var response = await repository.addGameToWishList(game: game, uid: uid);
    return response;
  }

}