// dependency injection
LikeTracker injectLikeTracker(){
  return LikeTracker.getInstance();
}

class LikeTracker {

  // singleton pattern
  LikeTracker._();
  static LikeTracker? _instance;
  static LikeTracker getInstance(){
    return _instance ??= LikeTracker._();
  }

  int count = 0 ;
  List<String> data = [ "" , "" , "" , "" , "" ];

  Future<void> addGenres({required List<String> genres})async{
    for(int i =0 ; i<genres.length ;i++){

    }
  }

}