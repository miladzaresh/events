import 'package:get/get.dart';
import '../../../../events.dart';
import '../../../../generated/locales.g.dart';
import '../../shared/enums/authorization_enum.dart';
import '../repository/splash_repository.dart';
class SplashController extends GetxController{
  RxString welcomeText=''.obs;

  final SplashRepository repository=SplashRepository();

  @override
  void onInit() {
    super.onInit();
    welcomeText.value=LocaleKeys.splash_page_welcome_text.tr;
    checkLogin();
  }
  void checkLogin(){
    Future.delayed(Duration(
        seconds: 2
    ),()async{
      final auth=await repository.fetchAuth();
      if(auth == Authorization.author){
        Get.offAndToNamed(RouteNames.main);
      }else{
        Get.offAndToNamed(RouteNames.login);
      }
    });
  }
}