import 'package:El3b/Domain/Models/Games/RAWG/RAWGGame.dart';

abstract class WishListLocalDataSource{

  Future<int> addGameToWishList({required RAWGGame game ,required String uid});
  Future<int> deleteGameFromWishList({required int game ,required String uid});
  Future<List<RAWGGame>?> loadGamesFromWishList({required String uid});

}