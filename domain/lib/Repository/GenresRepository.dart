
import 'package:domain/Models/Genres/Genre.dart';

abstract class GenresRepository {

  Future<List<Genre>?> getGenres();

}