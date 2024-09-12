import 'package:core/Extension/DateOnlyExtinsion.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dependency injection
LocalCache injectLocalCache(){
  return LocalCache.getInstance();
}

class LocalCache {

  // singleton pattern
  LocalCache._();
  static LocalCache? _instance;
  static LocalCache getInstance(){
    return _instance ??= LocalCache._();
  }

  SharedPreferences? _preferences ;

  // function to get instance of shared preferences
  Future<SharedPreferences> getSharedPref()async{
    return _preferences ??= await SharedPreferences.getInstance();
  }

  // function to cache data
  Future<void> cacheData({required String data , required String key})async{

    var pref = await getSharedPref();
    await pref.setString(key, data);
    await pref.setString("${key}LastUpdated", DateTime.now().dateOnly(DateTime.now()).toString());

  }

  // function to get last updated date for any cached data
  Future<DateTime?> lastUpdatedDate({required String key})async{

    var pref = await getSharedPref();
    var response = pref.getString("${key}LastUpdated");
    return response == null ? null : DateTime.parse(response);

  }

  // function to load the cached data in shared pref
  Future<String?> loadData({required String key})async {
    var pref = await getSharedPref();
    var response = pref.getString(key);
    return response;
  }

}