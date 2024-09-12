
import 'package:domain/Models/Genres/Genre.dart';

abstract class GenresListRemoteDataSource {
  Future<List<Genre>?>  getAllGenres();
}