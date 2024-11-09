import 'package:events/events.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../shared/widget/filter_view.dart';
import '../../shared/widget/loading_app.dart';
import '../../shared/widget/toast.dart';
import '../model/my_event_view_model.dart';
import '../repository/my_event_repository.dart';
import 'dart:math';
class MyEventController extends GetxController{
  final RxList<MyEventViewModel> events=RxList();
  RxBool isLoading=true.obs;
  RxBool isRetry=false.obs;
  final MyEventRepository repository=MyEventRepository();
  RxMap<String,dynamic> deleteLoading=RxMap();
  final TextEditingController searchTitleController = TextEditingController();
  // filter values
  RxInt valuePrice = 0.obs, minPrice = 0.obs, maxPrice = 0.obs;
  RxBool isExpired = false.obs, isSorted = false.obs, haveCapacity = false.obs;
  int priceFilter=0;
  bool isClearFilter=true;


  @override
  void onInit() {
    super.onInit();
    getMyEvent();
  }

  void getMyEvent()async{
    events.clear();
    isLoading.value=true;
    isRetry.value=false;
    final responseOrException=await repository.getEvents();
    responseOrException.fold((left){
      isLoading.value=false;
      isRetry.value=true;
      showToast(left, true);
    }, (right){
      isLoading.value=false;
      events.addAll(right);
      right.forEach((element) {
        deleteLoading.addAll({
          element.id.toString():false
        });
      });
    });
  }

  void onSearch() {
    searchAndFilter();
  }

  void onShowFilter() async{
    Get.dialog(LoadingApp());
    final responseOrException = await repository.getEvents();
    responseOrException.fold((left) {
      Get.back();
      showToast(left, true);
    }, (right) {
      Get.back();
      final List<int> prices=List.from(right.map((e)=>e.price));
      maxPrice.value=prices.reduce(max);
      minPrice.value=prices.reduce(min);
      if(isClearFilter){
        valuePrice.value=minPrice.value;
      }
    });
    showModalBottomSheet(
      context: Get.context!,
      builder: (_) => Obx(() => FilterView(
          isExpired: isExpired.value,
          isSorted: isSorted.value,
          haveCapacity: haveCapacity.value,
          minPrice: minPrice.value,
          maxPrice: maxPrice.value,
          valuePrice: valuePrice.value,
          onChangeHaveCapacity: onChangedHaveCapacity,
          onChangeIsExpired: onChangedExpired,
          onChangeIsSorted: onChangedSorted,
          onChangePrice: onChangePrice,
          onClose: onCloseFilter,
          onFilterClear: onClearFilter,
          onSubmit: onSubmitFilter,
          isClear:isClearFilter
      )),
    );
  }

  void searchAndFilter() async {
    events.clear();
    isLoading.value = true;
    isRetry.value = false;
    final responseOrException = await repository.searchAndFilterEvent(
      isExpired.value,
      isSorted.value,
      haveCapacity.value,
      priceFilter,
      searchTitleController.text,
    );
    responseOrException.fold((left) {
      isLoading.value = false;
      isRetry.value = true;
      showToast(left, true);
    }, (right) {
      isLoading.value = false;
      events.addAll(right);

    });
  }

  void onCloseFilter() => Get.back();

  void onClearFilter() {
    isExpired.value = false;
    isSorted.value = false;
    haveCapacity.value = false;
    priceFilter=0;
    isClearFilter=true;
    Get.back();
    searchAndFilter();
  }

  void onSubmitFilter() {
    isClearFilter=false;
    searchAndFilter();
    Get.back();
  }

  void onChangePrice(double? val) {
    valuePrice.value = val!.toInt();
    priceFilter=val.toInt();
  }

  void onChangedSorted(bool? val) {
    isSorted.value = val!;
  }

  void onChangedExpired(bool? val) {
    isExpired.value = val!;
  }

  void onChangedHaveCapacity(bool? val) {
    haveCapacity.value = val!;
  }

  Future<void> onRefresh() async {
    searchTitleController.clear();
    isExpired.value = false;
    isSorted.value = false;
    haveCapacity.value = false;
    priceFilter=0;
    isClearFilter=true;
    getMyEvent();
  }

  void onChangeLanguage() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? localeKey=pref.getString(LocalStorageKeys.languageLocale);
    if(localeKey == null){
      localeKey='fa';
      pref.setString(LocalStorageKeys.languageLocale, 'fa');
    }else{
      if(localeKey == 'fa'){
        localeKey='en';
        pref.setString(LocalStorageKeys.languageLocale, 'en');

      }else if(localeKey == 'en'){
        localeKey='fa';
        pref.setString(LocalStorageKeys.languageLocale, 'fa');

      }
    }
    Get.updateLocale(Locale(localeKey,));
  }
  void goToAddEvent()async{
    final result=await Get.toNamed(RouteNames.addEvent);
    print(result);
    if(result != null){
      events.add(MyEventViewModel.fromJson(result!));
    }
  }


  void goToEditPage(MyEventViewModel model)async{
    if(model.capacity == (model.rowCount * model.columnCount)){
      final result= await Get.toNamed(RouteNames.editEvent,parameters: {'id':model.id.toString()});
      if(result != null){
        MyEventViewModel newEvent=MyEventViewModel.fromJson(result);
        int index=events.indexWhere((element) => element.id==model.id);
        if(index != -1){
          events[index]=events[index].copyWith(
            title: newEvent.title,
            description: newEvent.description,
            image: newEvent.image,
            rowCount: newEvent.rowCount,
            columnCount: newEvent.columnCount,
            price: newEvent.price,
            purchases: newEvent.purchases,
            userId: newEvent.userId,
            dateTime: newEvent.dateTime,
            id: newEvent.id,
            capacity: newEvent.capacity,
          );
        }
      }
    }else{
      showToast(LocaleKeys.my_event_page_error_capacity_message.tr, true);
    }
  }

  void deleteEvent(MyEventViewModel model)async{
    if(model.capacity == (model.rowCount * model.columnCount)){
      deleteLoading[model.id.toString()]=true;
      final responseOrException=await repository.deleteEvent(model.id);
      responseOrException.fold((left) {
        deleteLoading[model.id.toString()]=true;
        showToast(left, true);
      }, (right){
        deleteLoading[model.id.toString()]=true;
        events.removeWhere((element) => element.id==model.id);
        showToast(LocaleKeys.shared_text_success.tr, false);
      });
    }else{
      showToast(LocaleKeys.my_event_page_error_capacity_message.tr, true);
    }
  }

}