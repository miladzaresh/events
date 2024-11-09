import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../model/my_event_view_model.dart';
class MyEventRepository{
  final AppApi api=AppApi();
  Future<Either<String, List<MyEventViewModel>>> getEvents() async {
    try {
      final SharedPreferences preferences=await SharedPreferences.getInstance();
      final int userId=preferences.getInt(LocalStorageKeys.userId)??-1;
      if(userId == -1){
        return Right([]);
      }
      final response = await api.getAsync(RepositoryUrls.myEvents(userId.toString()));
      return Right(
        List<MyEventViewModel>.from(
            response.data.map((item) => MyEventViewModel.fromJson(item))),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, List<MyEventViewModel>>> searchAndFilterEvent(bool isExpired,bool isSortedDate , bool haveCapacity,int price,String title) async {
    try {
      final SharedPreferences preferences=await SharedPreferences.getInstance();
      final int userId=preferences.getInt(LocalStorageKeys.userId)??-1;
      final response = await api.getAsync(RepositoryUrls.searchMyEvents(title, price==0?'':price.toString(),userId.toString()));
      final pref=await SharedPreferences.getInstance();
      if(response.data.toString()=='[]'){
        return Right([]);
      }
      final result=List<MyEventViewModel>.from(
          response.data.map((item) => MyEventViewModel.fromJson(item)));
      if(haveCapacity){
        result.removeWhere((element) => element.capacity==0);
      }
      if(isExpired){
        result.removeWhere((element) => element.dateTime.isBefore(DateTime.now()));
      }
      if(isSortedDate){
        result.sort((a,b)=>a.dateTime.compareTo(b.dateTime));
      }
      return Right(result);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteEvent(int id) async {
    try {
      final response = await api.delete(RepositoryUrls.deleteEvents(id.toString()));
      return Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

}