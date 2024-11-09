

import '../../../infrastructure/app_api/app_api.dart';
import 'package:either_dart/either.dart';

import '../../../infrastructure/common/repository_url.dart';
import '../model/edit_event_dto.dart';
import '../model/event_details_view_model.dart';
class EditEventRepository{
  final AppApi api=AppApi();
  Future<Either<String, EventDetailsViewModel>> getEventDetails(String eventId) async {
    try {
      final response = await api.getAsync(RepositoryUrls.getEventDetails(eventId));
      return Right(EventDetailsViewModel.fromJson(response.data));
    } catch (e) {
      print('-------$e');
      return Left(e.toString());
    }
  }
  Future<Either<String, EventDetailsViewModel>> editEvent(String eventId,EditEventDto dto) async {
    try {
      print(RepositoryUrls.editEvent(eventId));
      final response = await api.patchAsync(RepositoryUrls.editEvent(eventId), dto.toMap());
      return Right(EventDetailsViewModel.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}