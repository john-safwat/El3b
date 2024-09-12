import 'package:data/Repository/RAWGGamesRepositoryImpl.dart';
import 'package:domain/Repository/RAWGGamesRepository.dart';


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