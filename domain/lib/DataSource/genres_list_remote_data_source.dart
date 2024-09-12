
import 'package:domain/Models/Genres/genre.dart';

abstract class GenresListRemoteDataSource {
  Future<List<Genre>?>  getAllGenres();
}