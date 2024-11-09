
import 'package:either_dart/either.dart';

import '../../../infrastructure/app_api/app_api.dart';
import '../../../infrastructure/common/repository_url.dart';
import '../model/login_dto.dart';
import '../model/user_view_model.dart';

class LoginRepository {
  final AppApi api = AppApi();

  Future<Either<String, UserViewModel?>> login(LoginDto dto) async {
    try {
      final response = await api.getAsync(
        RepositoryUrls.login(dto.username, dto.password),
      );
      if(response.data.toString() == '[]'){
        return Right(null);
      }
      return Right(UserViewModel.fromJson(response.data[0]));
    } catch (e) {
      print('error $e');
      return Left(e.toString());
    }
  }
}
