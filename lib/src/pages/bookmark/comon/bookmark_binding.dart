import 'package:get/get.dart';

import '../controller/bookmark_controller.dart';
class BookmarkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BookmarkController());

  }
}