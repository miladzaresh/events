import 'package:get/get.dart';

import '../../bookmark/controller/bookmark_controller.dart';
import '../../event_list/controller/event_list_controller.dart';
import '../../my_event/controller/my_event_controller.dart';
import '../controller/main_controller.dart';
class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => EventListController());
    Get.lazyPut(() => MyEventController());
    Get.lazyPut(() => BookmarkController());
  }
}