import 'package:El3b/Data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';

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