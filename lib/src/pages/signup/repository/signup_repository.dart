import 'package:either_dart/either.dart';
import '../../../infrastructure/app_api/app_api.dart';
import '../model/user_view_model.dart';

import '../../../infrastructure/common/repository_url.dart';
import '../model/signup_dto.dart';

class SignupRepository{
  final AppApi api=AppApi();
  Future<Either<String,UserViewModel>> signup(SignupDto dto)async{
    try{
      final response=await api.postAsync(
        RepositoryUrls.signup,
        dto.toMap()
      );

      return Right(UserViewModel.fromJson(response.data));
    }catch (e){
      return Left(e.toString());
    }
  }

}