import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/main_controller.dart';
import 'widget/app_bottom_navigation_bar.dart';

class MainScreen extends GetView<MainController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body(),
        bottomNavigationBar: AppBottomNavigationBar(items:controller.icons ,),
      );

  Widget _body() {
    return PageView.builder(
      itemBuilder: (context,index)=>controller.pages[index],
      itemCount: controller.pages.length,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: controller.onTapItem,
      controller: controller.pageViewController,
    );
  }
}
