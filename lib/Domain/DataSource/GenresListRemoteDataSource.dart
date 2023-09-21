
import 'package:El3b/Domain/Models/Genres/Genre.dart';

abstract class GenresListRemoteDataSource {
  Future<List<Genre>?>  getAllGenres();
}