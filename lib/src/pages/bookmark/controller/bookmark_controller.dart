import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../../../events.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/storage/local_storage_keys.dart';
import '../../shared/widget/filter_view.dart';
import '../../shared/widget/loading_app.dart';
import '../../shared/widget/toast.dart';
import '../model/bookmark_dto.dart';
import '../model/bookmark_view_model.dart';
import '../repository/bookmark_repository.dart';
import 'dart:math';
class BookmarkController extends GetxController{
  final RxList<BookmarkViewModel> events=RxList();
  RxBool isLoading=true.obs;
  RxBool isRetry=false.obs;
  final BookmarkRepository repository=BookmarkRepository();
  final TextEditingController searchTitleController = TextEditingController();
  RxMap<String, dynamic> bookmarkLoading = RxMap();
  // filter values
  RxInt valuePrice = 0.obs, minPrice = 0.obs, maxPrice = 0.obs;
  RxBool isExpired = false.obs, isSorted = false.obs, haveCapacity = false.obs;
  int priceFilter=0;
  bool isClearFilter=true;


  @override
  void onInit() {
    super.onInit();
    getBookmark();
  }
  void getBookmark()async{
    events.clear();
    isLoading.value=true;
    isRetry.value=false;
    final responseOrException=await repository.getBookmark();
    responseOrException.fold((left){
      isLoading.value=false;
      isRetry.value=true;
      showToast(left, true);
    }, (right){
      isLoading.value=false;
      events.addAll(right);
      right.forEach((element) {
        bookmarkLoading.addAll({element.id.toString(): false});
      });
    });
  }


  void onSearch() {
    searchAndFilter();
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

  void onShowFilter() async{
    Get.dialog(LoadingApp());
    final responseOrException = await repository.getBookmark();
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
    final responseOrException = await repository.searchAndFilterBookmark(
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
      right.forEach((element) {
        bookmarkLoading.addAll({element.id.toString(): false});
      });
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
    isClearFilter=false;
    getBookmark();
  }

  void goToDetails(int id,bool isNotExpired){
    if(isNotExpired){
      Get.toNamed(RouteNames.eventDetails,parameters: {'id':id.toString()});
    }else{
      showToast(LocaleKeys.shared_text_expired_event.tr, true);
    }
  }


  void bookmarkEvent(BookmarkViewModel model) async {
    if(model.isBookmark){
      unBookmark(model);
    }else{
      bookmark(model);
    }
  }
  void bookmark(BookmarkViewModel model) async {
    bookmarkLoading[model.id.toString()] = true;
    final pref=await SharedPreferences.getInstance();
    final responseOrException = await repository.bookmarkEvent(
        BookmarkDto(
          image: model.image,
          title: model.title,
          description: model.description,
          dateTime: '${model.dateTime.year}-${model.dateTime.month}-${model.dateTime.day}',
          capacity: model.capacity,
          price: model.price,
          eventId: model.id,
          userId: pref.getInt(LocalStorageKeys.userId)??-1,
          purchases: model.purchases.map((e) => PurchaseDto(userId: e.userId, isPurchase: e.isPurchase)).toList(),
          columnCount: model.columnCount,
          rowCount: model.rowCount,
        ));
    responseOrException.fold((left) {
      bookmarkLoading[model.id.toString()] = false;
      showToast(left, true);
    }, (right) {
      bookmarkLoading[model.id.toString()] = false;
      int index=events.indexWhere((element) => element.id==model.id);
      if(index != -1){
        events[index]=events[index].copyWith(isBookmark: !model.isBookmark);
      }
      showToast(LocaleKeys.shared_text_success.tr, false);
    });
  }
  void unBookmark(BookmarkViewModel model) async {
    bookmarkLoading[model.id.toString()] = true;
    final responseOrException = await repository.unBookmarkEvent(model);
    responseOrException.fold((left) {
      bookmarkLoading[model.id.toString()] = false;
      showToast(left, true);
    }, (right) {
      bookmarkLoading[model.id.toString()] = false;
      events.removeWhere((element) => element.id==model.id);
      showToast(LocaleKeys.shared_text_success.tr, false);
    });
  }
}