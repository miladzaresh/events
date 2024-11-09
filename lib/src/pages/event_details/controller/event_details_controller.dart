import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_package/purchase_package.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../shared/widget/loading_app.dart';
import '../../shared/widget/toast.dart';
import '../model/details_dto.dart';
import '../model/details_view_model.dart';
import '../repository/event_details_repository.dart';

class EventDetailsController extends GetxController {
  final String eventId;

  EventDetailsController({required this.eventId});

  Rxn<DetailsViewModel> event = Rxn();
  RxBool isLoading = false.obs;
  RxBool isLoadingPost = false.obs;
  final EventDetailsRepository repository = EventDetailsRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEvent();
  }

  void getEvent() async {
    isLoading.value = true;
    final responseOrException = await repository.getEventDetails(eventId);
    responseOrException.fold((left) {
      isLoading.value = false;
      showToast(left, true);
    }, (right) {
      isLoading.value = false;
      event.value = right;
    });
  }

  void onPurchase() async {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        actions: [
          Obx(() => IconButton(
                icon: isLoadingPost.value
                    ? LoadingApp()
                    : Icon(
                        Icons.done,
                        color: Colors.blue,
                      ),
                onPressed: isLoadingPost.value?null:() {
                  purchaseChairs();
                },
              )),
          IconButton(
            icon: isLoadingPost.value
                ? LoadingApp()
                : Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
        content: PurchaseScreen(
          items: List.from(event.value!.purchases.map((e) => e.isPurchase)),
          onTap: (int index) async {
            print('asdsad --------- $index');
            final pref = await SharedPreferences.getInstance();
            final myId = pref.getInt(LocalStorageKeys.userId) ?? 0;
            if (event.value!.purchases[index].userId == myId ||
                event.value!.purchases[index].userId == -1) {
              bool value = !event.value!.purchases[index].isPurchase;
              event.value!.purchases[index] = event.value!.purchases[index]
                  .copyWith(isPurchase: value, userId: myId);
              return value;
            }
            showToast(LocaleKeys.event_details_page_other_purchase.tr, true);
            return null;
          },
        ),
        title: new Text(
          LocaleKeys.event_details_page_choose_chair.tr,
          style:
              new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        contentPadding: const EdgeInsets.all(10.0),
      ),
    );
  }

  void purchaseChairs() async {
    isLoadingPost.value = true;
    int sum = 0;
    event.value!.purchases.forEach((element) {
      if (element.isPurchase) {
        sum++;
      }
    });
    DetailsDto dto = DetailsDto(
      image: event.value!.image,
      title: event.value!.title,
      description: event.value!.description,
      dateTime: event.value!.dateTime,
      capacity: (event.value!.capacity - sum),
      rowCount: event.value!.rowCount,
      columnCount: event.value!.columnCount,
      price: event.value!.price,
      userId: event.value!.userId,
      purchases: event.value!.purchases
          .map((e) => PurchaseDto(userId: e.userId, isPurchase: e.isPurchase))
          .toList(),
    );
    final responseOrException = await repository.purchase(eventId, dto);
    responseOrException.fold((left) {
      isLoadingPost.value = false;
      showToast(left, true);
    }, (right) {
      isLoadingPost.value = false;
      event.value = right;
      Get.back();
    });
  }
}
