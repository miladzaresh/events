import 'package:get/get.dart';

import '../controller/event_list_controller.dart';
class EventListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EventListController());
  }
}