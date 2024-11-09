import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../../infrastructure/utils.dart';
import '../../shared/widget/custom_date_time.dart';
import '../../shared/widget/toast.dart';
import '../model/add_event_dto.dart';
import '../model/event_view_model.dart';
import '../repository/add_event_repository.dart';

class AddEventController extends GetxController {
  RxBool isLoadingPost = false.obs;
  Rxn<XFile> imagePick = Rxn<XFile>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  int capacity = 0;
  RxInt columnCount = 0.obs, rowCount = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AddEventRepository repository = AddEventRepository();

  void columnCountChanged(int? val) {
    if (val != null) {
      columnCount.value = val;
    }
  }

  void rowCountChanged(int? val) {
    if (val != null) {
      rowCount.value = val;
    }
  }

  String? validateFields(String? val) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return LocaleKeys.shared_text_empty_filed_message.tr;
    }
    return null;
  }

  void addEvent() async {
    if (formKey.currentState?.validate() ?? false) {
      if (columnCount.value == 0 || rowCount.value == 0) {
        showToast(
            LocaleKeys.add_event_page_choose_column_row_error_message.tr, true);
      } else {
        isLoadingPost.value = true;
        capacity = (rowCount.value * columnCount.value);
        final List<PurchaseDto> purchases = [];
        for (int i = 0; i < capacity; i++) {
          purchases.add(PurchaseDto(userId: -1, isPurchase: false));
        }
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final responseOrException = await repository.addEvent(
          AddEventDto(
              image: await encodeImage(imagePick.value),
              title: titleController.text,
              description: descriptionController.text,
              dateTime: dateTimeController.text,
              capacity: capacity,
              rowCount: rowCount.value,
              columnCount: columnCount.value,
              userId: preferences.getInt(LocalStorageKeys.userId) ?? -1,
              price: int.tryParse(priceController.text) ?? 0,
              purchases: purchases),
        );
        AddEventViewModel? viewModel = null;
        responseOrException.fold((left) {
          isLoadingPost.value = false;
          showToast(left, true);
        }, (right) {
          isLoadingPost.value = false;
          viewModel = right;
        });
        showToast(LocaleKeys.add_event_page_successfully.tr, false);
        Get.back(result: viewModel);
      }
    }
  }

  void pickImage() async {
    XFile? imagePath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePath != null) {
      final test = await imagePath.readAsBytes();
      imagePick.value = imagePath;
    }
  }

  void chooseDate() async {
    showDialog(context: Get.context!, builder: (_)=>AlertDialog(
      title: Text(
        LocaleKeys.add_event_page_choose_date_time.tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
      content: CustomDateWidget(onChoose: choosingDate,),
      actions: [
        IconButton(onPressed: (){
          dateTimeController.clear();
          Get.back();
        }, icon:Icon(Icons.close,size: 24,color: Colors.red,)),
        IconButton(onPressed: (){
          Get.back();
        }, icon:Icon(Icons.check,size: 24,color: Colors.green,))
      ],
    ),);
  }

  void choosingDate(String value){
    String year=value.split('-')[0];
    String month=value.split('-')[1];
    String day=value.split('-')[2];
    if(int.tryParse(month) != null && int.tryParse(month)! < 10){
      month='0$month';
    }
    if(int.tryParse(day) != null && int.tryParse(day)! < 10){
      day='0$day';
    }
    dateTimeController.text='$year-$month-$day';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
  }
}
