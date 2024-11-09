import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../model/bookmark_event_view_model.dart';
import '../model/bookmark_event_dto.dart';
import '../model/event_view_model.dart';

class EventListRepository {
  final AppApi api = AppApi();

  Future<Either<String, List<EventViewModel>>> getEvents() async {
    try {
      final response = await api.getAsync(RepositoryUrls.getEvents);
      final pref=await SharedPreferences.getInstance();
      final responseBookmark = await api.getAsync(RepositoryUrls.bookmarkEvents('${pref.getInt(LocalStorageKeys.userId)??0}'));
      if(response.data.toString()=='[]'){
        return Right([]);
      }
      final result=List<EventViewModel>.from(
          response.data.map((item) => EventViewModel.fromJson(item)));
      final resultBookmark=List<BookmarkEventViewModel>.from(
          responseBookmark.data.map((item) => BookmarkEventViewModel.fromJson(item)));
      resultBookmark.forEach((elementBookmark) {
        int index=result.indexWhere((element) => element.id==elementBookmark.eventId);
        if(index != -1){
          print('asd============');
          result[index]=result[index].copyWith(isBookmark: !result[index].isBookmark);

        }
      });
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, List<EventViewModel>>> searchAndFilterEvent(bool isExpired,bool isSortedDate , bool haveCapacity,int price,String title) async {
    try {
      final response = await api.getAsync(RepositoryUrls.searchEvents(title, price==0?'':price.toString()));
      final pref=await SharedPreferences.getInstance();
      final responseBookmark = await api.getAsync(RepositoryUrls.bookmarkEvents('${pref.getInt(LocalStorageKeys.userId)??0}'));
      if(response.data.toString()=='[]'){
        return Right([]);
      }
      final result=List<EventViewModel>.from(
          response.data.map((item) => EventViewModel.fromJson(item)));
      final resultBookmark=List<BookmarkEventViewModel>.from(
          responseBookmark.data.map((item) => BookmarkEventViewModel.fromJson(item)));
      resultBookmark.forEach((elementBookmark) {
        int index=result.indexWhere((element) => element.id==elementBookmark.eventId);
        if(index != -1){
          result[index]=result[index].copyWith(isBookmark: !result[index].isBookmark);
        }
      });
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
  Future<Either<String, EventViewModel>> bookmarkEvent(BookmarkEventDto dto) async {
    try {
      final response = await api.postAsync(RepositoryUrls.addBookmark, dto.toMap());
      return Right(EventViewModel.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, bool>> unBookmarkEvent(EventViewModel model) async {
    try {
      final response = await api.getAsync(RepositoryUrls.getEvents);
      final pref=await SharedPreferences.getInstance();
      final responseBookmark = await api.getAsync(RepositoryUrls.bookmarkEvents('${pref.getInt(LocalStorageKeys.userId)??0}'));
      int bookmarkId=0;
      if(responseBookmark.data == []){
        return Right(false);
      }
      responseBookmark.data.forEach((e){
        if(e['event_id'] == model.id){
          bookmarkId=e['id'];
        }
      });
      final responseDeleteBookmark = await api.delete(RepositoryUrls.deleteBookmarkEvents(bookmarkId.toString()));
      return Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
