import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class AppBottomNavigationBar extends GetView<MainController> {
  final List<IconData> items;

  AppBottomNavigationBar({required this.items});

  @override
  Widget build(BuildContext context) => Obx(
        () => BottomNavigationBar(
          items: items
              .map<BottomNavigationBarItem>(
                  (icon) => BottomNavigationBarItem(icon: Icon(icon),label: ''))
              .toList(),
          currentIndex: controller.currentItem.value,
          onTap: controller.onTapItem,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.shade500,
        ),
      );
}
