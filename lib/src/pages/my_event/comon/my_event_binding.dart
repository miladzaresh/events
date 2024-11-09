import 'package:get/get.dart';

import '../controller/my_event_controller.dart';
class MyEventBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MyEventController());
  }
}