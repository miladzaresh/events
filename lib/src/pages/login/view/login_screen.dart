import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locales.g.dart';
import '../../shared/widget/custom_text_filed.dart';
import '../../shared/widget/general_button.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12,),
                    Text(
                      LocaleKeys.login_page_title_text.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      title: LocaleKeys.login_page_username_text.tr,
                      controller: controller.usernameController,
                      type: TextInputType.text,
                      onValidator: controller.validateUsername,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(() => CustomTextFormField(
                          title: LocaleKeys.login_page_password_text.tr,
                          controller: controller.passwordController,
                          type: TextInputType.visiblePassword,
                          toggle: IconButton(
                            onPressed: controller.changeObserve,
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          observed: controller.obsserved.value,
                          onValidator: controller.validatePassword,
                        )),

                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                              () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: controller.changeRemember,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          LocaleKeys.login_page_remember_me_text.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                        onPressed: controller.goToSignup,
                        child: Text(
                          LocaleKeys.login_page_signup_text.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    Obx(() => GeneralButton(
                          onPress: controller.isLoadingPost.value
                              ? null
                              : controller.login,
                          title: LocaleKeys.login_page_title_text.tr,
                        )),
                    SizedBox(height: 12,)
                  ],
                ),
                key: controller.formKey,
              ),
            ),
          ),
        ),
      );
}
