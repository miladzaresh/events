import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../model/bookmark_dto.dart';
import '../model/bookmark_view_model.dart';
class BookmarkRepository{
  final AppApi api=AppApi();
  Future<Either<String, List<BookmarkViewModel>>> getBookmark() async {
    try {
      final SharedPreferences preferences=await SharedPreferences.getInstance();
      final int userId=preferences.getInt(LocalStorageKeys.userId)??-1;
      if(userId == -1){
        return Right([]);
      }
      final response = await api.getAsync(RepositoryUrls.bookmarkEvents(userId.toString()));
      return Right(
        List<BookmarkViewModel>.from(
            response.data.map((item) => BookmarkViewModel.fromJson(item))),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, List<BookmarkViewModel>>> searchAndFilterBookmark(bool isExpired,bool isSortedDate , bool haveCapacity,int price,String title) async {
    try {
      final SharedPreferences preferences=await SharedPreferences.getInstance();
      final int userId=preferences.getInt(LocalStorageKeys.userId)??-1;
      final response = await api.getAsync(RepositoryUrls.searchBookmarks(title, price==0?'':price.toString(),userId.toString()));
      final pref=await SharedPreferences.getInstance();
      if(response.data.toString()=='[]'){
        return Right([]);
      }
      final result=List<BookmarkViewModel>.from(
          response.data.map((item) => BookmarkViewModel.fromJson(item)));
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


  Future<Either<String, BookmarkViewModel>> bookmarkEvent(BookmarkDto dto) async {
    try {
      final response = await api.postAsync(RepositoryUrls.addBookmark, dto.toMap());
      return Right(BookmarkViewModel.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, bool>> unBookmarkEvent(BookmarkViewModel model) async {
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