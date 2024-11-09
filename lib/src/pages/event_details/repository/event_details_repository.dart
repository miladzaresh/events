
import 'package:either_dart/either.dart';

import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../model/details_dto.dart';
import '../model/details_view_model.dart';

class EventDetailsRepository{
  final AppApi api=AppApi();
  Future<Either<String, DetailsViewModel>> getEventDetails(String eventId) async {
    try {
      final response = await api.getAsync(RepositoryUrls.getEventDetails(eventId));
      return Right(DetailsViewModel.fromJson(response.data));
    } catch (e) {
      print('-------$e');
      return Left(e.toString());
    }
  }
  Future<Either<String, DetailsViewModel>> purchase(String eventId,DetailsDto dto) async {
    try {
      print(RepositoryUrls.editEvent(eventId));
      final response = await api.patchAsync(RepositoryUrls.editEvent(eventId), dto.toMap());
      return Right(DetailsViewModel.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}