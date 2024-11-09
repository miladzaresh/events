import 'package:get/get.dart';

import '../controller/event_details_controller.dart';
class EventDetailsBinding extends Bindings{
  @override
  void dependencies() {
    final parameters = Get.parameters;
    Get.lazyPut(() => EventDetailsController(eventId: parameters['id'] ?? ''));
  }
}