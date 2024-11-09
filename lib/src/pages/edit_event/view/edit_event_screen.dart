import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils.dart';
import '../../shared/widget/custom_text_filed.dart';
import '../../shared/widget/drop_dwon_wdiget.dart';
import '../../shared/widget/general_button.dart';
import '../../shared/widget/loading_app.dart';
import '../controller/edit_event_controller.dart';
class EditEventScreen extends GetView<EditEventController> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        LocaleKeys.edit_event_page_name.tr,
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    ),
    body: Obx(()=>_body()),
    bottomNavigationBar: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(()=>GeneralButton(
        onPress:
        controller.isLoadingPost.value ? null : controller.editEvent,
        title: LocaleKeys.shared_text_submit.tr,
      )),
    ),
  );

  Widget _body(){
    if(controller.isLoading.value){
      return LoadingApp();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Obx(() => _imagePicking()),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                title: LocaleKeys.edit_event_page_title.tr,
                controller: controller.titleController,
                type: TextInputType.text,
                onValidator: controller.validateFields,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                title: LocaleKeys.edit_event_page_description.tr,
                controller: controller.descriptionController,
                type: TextInputType.text,
                onValidator: controller.validateFields,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                title: LocaleKeys.edit_event_page_price.tr,
                controller: controller.priceController,
                type: TextInputType.number,
                onValidator: controller.validateFields,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                title: LocaleKeys.edit_event_page_choose_date_time.tr,
                controller: controller.dateTimeController,
                type: TextInputType.number,
                onValidator: controller.validateFields,
                onTap: controller.chooseDate,
              ),
              SizedBox(height: 16,),
              Text(
                LocaleKeys.edit_event_page_choose_column_row.tr,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 6,),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropDownWidget(value: controller.columnCount.value, maxValue: 20,onChange: controller.columnCountChanged,),
                  SizedBox(width: 24,),
                  DropDownWidget(value: controller.rowCount.value, maxValue: 20,onChange: controller.rowCountChanged,),
                ],
              ))

            ],
          ),
        ),
      ),
    );
  }
  Widget _imagePicking() {
    if (controller.imagePick['image'] == null) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(32),
          ),
          height: 300,
          alignment: Alignment.center,
          child: Icon(
            Icons.image_aspect_ratio_outlined,
            size: 24,
            color: Colors.grey.shade600,
          ),
        ),
        onTap: controller.pickImage,
      );
    }else if(controller.imagePick['type']=='image-picker'){
      if (kIsWeb) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: NetworkImage(controller.imagePick['image'].path),
              )),
          height: 300,
        );
      }
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
              image: FileImage(File(controller.imagePick['image'].path)),
            )),
        height: 300,
      );
    }else{
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: MemoryImage(decodeBase64ToFile(controller.imagePick['image'])),
              )),
          height: 300,
        ),
        onTap: controller.pickImage,
      );
    }
  }
}
