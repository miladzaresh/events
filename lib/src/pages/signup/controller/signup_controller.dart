import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/enums/gender_enum.dart';
import '../../shared/widget/toast.dart';
import '../model/signup_dto.dart';
import '../repository/signup_repository.dart';

class SignupController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool obsserved = true.obs;
  RxBool isLoadingPost = false.obs;
  Rx<Genders> selectedGender = Genders.male.obs;
  final SignupRepository repository = SignupRepository();

  String? validateFirstName(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    return null;
  }

  String? validateLastName(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    return null;
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

  String? validateConfirmPassword(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    if (val != passwordController.text) {
      return LocaleKeys.signup_page_confirm_password_error_message.tr;
    }
    return null;
  }

  void changeObserve() {
    obsserved.value = !obsserved.value;
  }

  void chooseGender(Genders gender) {
    selectedGender.value = gender;
  }

  void signup() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoadingPost.value = true;
      final responseOrException = await repository.signup(SignupDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: usernameController.text,
        password: passwordController.text,
        gender: selectedGender.value.value,
      ));
      responseOrException.fold((left) {
        isLoadingPost.value = false;
        showToast(left, true);
      }, (right){
        isLoadingPost.value = false;
        showToast(LocaleKeys.login_page_success_toast.tr, false);
        Get.back();
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
  }
}
