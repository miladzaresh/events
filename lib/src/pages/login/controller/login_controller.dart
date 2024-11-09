import '../../../infrastructure/storage/local_storage_keys.dart';
import '../model/login_dto.dart';
import '../repository/login_repository.dart';
import '../../shared/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../events.dart';
import '../../../../generated/locales.g.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool obsserved = true.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoadingPost = false.obs;
  final LoginRepository repository = LoginRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeObserve() {
    obsserved.value = !obsserved.value;
  }

  void changeRemember(bool? value) {
    rememberMe.value = !rememberMe.value;
  }

  String? validateUsername(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    return null;
  }

  String? validatePassword(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    return null;
  }

  void goToSignup()async {
    await Get.toNamed(RouteNames.signup);
  }

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoadingPost.value = true;
      final responseOrException = await repository.login(LoginDto(
        username: usernameController.text,
        password: passwordController.text,
      ));
      responseOrException.fold((left) {
        isLoadingPost.value = false;
        showToast(left, true);
      }, (right) async {
        isLoadingPost.value = false;
        if (right == null) {
          showToast(LocaleKeys.login_page_user_not_found_toast.tr, true);
        } else {
          showToast(LocaleKeys.login_page_success_toast.tr, false);
          SharedPreferences preferences =
          await SharedPreferences.getInstance();
          if (rememberMe.value) {
            preferences.setBool(LocalStorageKeys.rememberMe, true);
          }
          preferences.setInt(LocalStorageKeys.userId, right.id);
          Get.offAndToNamed(RouteNames.main);
        }
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    usernameController.dispose();

  }
}
