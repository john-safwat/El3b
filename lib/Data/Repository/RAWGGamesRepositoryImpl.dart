
import 'package:El3b/Data/DataSource/RAWGGamesRemoteDataSourceImpl.dart';
import 'package:El3b/Data/DataSource/WishListLocalDataSourceImpl.dart';
import 'package:El3b/Domain/DataSource/RAWGGamesRemoteDataSource.dart';
import 'package:El3b/Domain/DataSource/WishListLocalDataSource.dart';
import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';
import 'package:El3b/Domain/Repository/RAWGGamesRepository.dart';


// dependency injection
RAWGGamesRepository injectRAWGGamesRepository(){
  return RAWGGamesRepositoryImpl(
    remoteDataSource: injectRAWGGamesRemoteDataSource(),
    wishListLocalDataSource: injectWishListLocalDataSource()
  );
}


class RAWGGamesRepositoryImpl implements RAWGGamesRepository {

  RAWGGamesRemoteDataSource remoteDataSource ;
  WishListLocalDataSource wishListLocalDataSource;
  RAWGGamesRepositoryImpl({
    required this.remoteDataSource ,
    required this.wishListLocalDataSource
  });

  // function to get the games to the home screen
  @override
  Future<List<RAWGGame>?> getGeneralGames() async {
    var response = await remoteDataSource.getGeneralGames();
    return response;
  }

  @override
  Future<int> addGameToWishList({required RAWGGame game, required String uid}) async{
    var response = await wishListLocalDataSource.addGameToWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<int> deleteGameFromWishList({required int game, required String uid}) async{
    var response = await wishListLocalDataSource.deleteGameFromWishList(game: game, uid: uid);
    return response;
  }

  @override
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid}) async{
    var response = await wishListLocalDataSource.loadGamesFromWishList(uid: uid);
    return response!;
  }

}