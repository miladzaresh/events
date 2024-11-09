
import '../../../../generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../shared/enums/gender_enum.dart';
import '../../shared/widget/custom_text_filed.dart';
import '../../shared/widget/general_button.dart';
import '../controller/signup_controller.dart';
import 'widget/choose_box.dart';

class SignupScreen extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12,),
                    Text(
                      LocaleKeys.signup_page_title_text.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      title: LocaleKeys.signup_page_first_name_text.tr,
                      controller: controller.firstNameController,
                      type: TextInputType.text,
                      onValidator: controller.validateFirstName,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                        title: LocaleKeys.signup_page_last_name_text.tr,
                        controller: controller.lastNameController,
                        type: TextInputType.text,
                        onValidator: controller.validateLastName),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      title: LocaleKeys.signup_page_username_text.tr,
                      controller: controller.usernameController,
                      type: TextInputType.text,
                      onValidator: controller.validateUsername,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => CustomTextFormField(
                          title: LocaleKeys.signup_page_password_text.tr,
                          controller: controller.passwordController,
                          type: TextInputType.visiblePassword,
                          onValidator: controller.validatePassword,
                          toggle: IconButton(
                            onPressed: controller.changeObserve,
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          observed: controller.obsserved.value,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => CustomTextFormField(
                          title:
                              LocaleKeys.signup_page_confirm_password_text.tr,
                          onValidator: controller.validateConfirmPassword,
                          controller: controller.confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          toggle: IconButton(
                            onPressed: controller.changeObserve,
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          observed: controller.obsserved.value,
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      LocaleKeys.signup_page_choose_gender_text.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ChooseBox(
                          gender: Genders.male,
                          selected: controller.selectedGender.value,
                          onChoose: controller.chooseGender,
                          title: LocaleKeys.signup_page_male_text.tr,
                        ),
                        ChooseBox(
                          gender: Genders.female,
                          selected: controller.selectedGender.value,
                          onChoose: controller.chooseGender,
                          title: LocaleKeys.signup_page_female_text.tr,
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 24,
                    ),
                    Obx(() => GeneralButton(
                      onPress: controller.isLoadingPost.value
                          ? null
                          : controller.signup,
                      title: LocaleKeys.signup_page_title_text.tr,
                    )),
                    SizedBox(height: 12,)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
