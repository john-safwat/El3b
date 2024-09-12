
import 'package:domain/Models/Genres/genre.dart';

abstract class GenresRepository {

  Future<List<Genre>?> getGenres();

}