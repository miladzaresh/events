import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../shared/enums/authorization_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashRepository{
  Future<Authorization> fetchAuth()async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    final bool checkRememberMe=sharedPreferences.getBool(LocalStorageKeys.rememberMe)??false;
    print('daswa $checkRememberMe');
    if(checkRememberMe){
      return Authorization.author;
    }
    return Authorization.notAuthor;
  }
}