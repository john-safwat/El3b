import 'package:data/Repository/rawg_games_repository_impl.dart';
import 'package:domain/Repository/rawg_games_repository.dart';


// dependency injection
DeleteGameFromWishListUseCase injectDeleteGameFromWishListUseCase(){
  return DeleteGameFromWishListUseCase(repository:  injectRAWGGamesRepository());
}

class DeleteGameFromWishListUseCase {

  RAWGGamesRepository repository ;
  DeleteGameFromWishListUseCase({required this.repository});

  Future<int> invoke({required int game , required String uid})async {
    var response = await repository.deleteGameFromWishList(game: game, uid: uid);
    return response;
  }

}