import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../bookmark/view/bookmark_screen.dart';
import '../../event_list/view/event_list_screen.dart';
import '../../my_event/view/my_event_screen.dart';

class MainController extends GetxController{
  RxInt currentItem=0.obs;
  final PageController pageViewController=PageController(initialPage: 0);
  final List<Widget> pages=[
    EventListScreen(),
    MyEventScreen(),
    BookmarkScreen(),
  ];
  final List<IconData> icons=[
    Icons.event,
    Icons.my_library_add,
    Icons.bookmark_add_outlined,

  ];
  void onTapItem(int page){
    currentItem.value=page;
    pageViewController.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageViewController.dispose();
  }
}