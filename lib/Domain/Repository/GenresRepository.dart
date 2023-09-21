
import 'package:El3b/Domain/Models/Genres/Genre.dart';

abstract class GenresRepository {

  Future<List<Genre>?> getGenres();

}