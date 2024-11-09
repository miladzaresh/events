import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../../infrastructure/utils.dart';
import '../../shared/widget/custom_date_time.dart';
import '../../shared/widget/toast.dart';
import '../model/edit_event_dto.dart';
import '../repository/edit_event_repository.dart';

class EditEventController extends GetxController {
  final String eventId;

  EditEventController({required this.eventId});

  RxBool isLoadingPost = false.obs;
  RxBool isLoading = false.obs;

  // Rxn<XFile> imagePick = Rxn<XFile>();
  RxMap imagePick = RxMap();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  int capacity = 0;
  RxInt columnCount = 0.obs, rowCount = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final EditEventRepository repository = EditEventRepository();
  String dateTime = '';

  void columnCountChanged(int? val) {
    if (val != null) {
      columnCount.value = val;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEvent(eventId);
  }

  void getEvent(String eventId) async {
    isLoading.value = true;
    final responseOrException = await repository.getEventDetails(eventId);
    responseOrException.fold((left) {
      isLoading.value = false;
      showToast(left, true);
    }, (right) {
      isLoading.value = false;
      titleController.text = right.title;
      descriptionController.text = right.description;
      priceController.text = right.price.toString();
      dateTimeController.text = right.dateTime;
      dateTime = right.dateTime;
      rowCount.value = right.rowCount;
      columnCount.value = right.columnCount;
      if (right.image != null) {
        imagePick.value = {
          'type': 'image-url',
          'image': right.image,
        };
      }else{
        imagePick.value = {
          'type': 'image-picker',
          'image': null,
        };
      }
    });
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

  void editEvent() async {
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
        final responseOrException = await repository.editEvent(
          eventId,
          EditEventDto(
              image: imagePick['type']=='image-url'?imagePick['image']:await encodeImage(imagePick['image']),
              title: titleController.text,
              description: descriptionController.text,
              dateTime: dateTimeController.text+' 00:00:00.000',
              capacity: capacity,
              rowCount: rowCount.value,
              columnCount: columnCount.value,
              userId: preferences.getInt(LocalStorageKeys.userId) ?? -1,
              price: int.tryParse(priceController.text) ?? 0,
              purchases: purchases),
        );
        responseOrException.fold((left) {
          isLoadingPost.value = false;
          showToast(left, true);
        }, (right) {
          isLoadingPost.value = false;
          showToast(LocaleKeys.add_event_page_successfully.tr, false);
          Get.back(result: right.toMap());
        });
      }
    }
  }

  void pickImage() async {
    XFile? imagePath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePath != null) {
      imagePick.value = {
        'type': 'image-picker',
        'image': imagePath,
      };
    }
  }

  void chooseDate() async {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: Text(
          LocaleKeys.add_event_page_choose_date_time.tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: CustomDateWidget(
          onChoose: choosingDate,
        ),
        actions: [
          IconButton(
              onPressed: () {
                dateTimeController.text = dateTime;
                Get.back();
              },
              icon: Icon(
                Icons.close,
                size: 24,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.check,
                size: 24,
                color: Colors.green,
              ))
        ],
      ),
    );
  }

  void choosingDate(String value) {
    dateTimeController.text = value;
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
