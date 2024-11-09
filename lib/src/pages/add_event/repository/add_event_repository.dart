import 'package:either_dart/either.dart';
import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../model/add_event_dto.dart';
import '../model/event_view_model.dart';

class AddEventRepository{
  final AppApi api=AppApi();
  Future<Either<String,AddEventViewModel?>> addEvent(AddEventDto dto)async{
    try {
      final response = await api.postAsync(
        RepositoryUrls.addEvent,
        dto.toMap()
      );
      if(response.data.toString() == '{}'){
        return Right(null);
      }
      return Right(AddEventViewModel.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}