import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/widget/empty_widget.dart';
import '../../shared/widget/general_app_bar.dart';
import '../../shared/widget/loading_app.dart';
import '../../shared/widget/retry_widget.dart';
import '../controller/event_list_controller.dart';
import 'widget/event_item.dart';

class EventListScreen extends GetView<EventListController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          child: GeneralAppBar(
            searchTitleController: controller.searchTitleController,
            onSearch: controller.onSearch,
            onShowFilter: controller.onShowFilter,
            onChangeLanguage: controller.onChangeLanguage,
          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: RefreshIndicator(
          child: Obx(()=>_body()),
          onRefresh: controller.onRefresh,
        ),
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return LoadingApp();
    } else if (controller.isRetry.value) {
      return RetryWidget(onTap: () {
        controller.getEvent();
      });
    } else if (controller.events.isEmpty) {
      return EmptyWidget(message: LocaleKeys.shared_text_empty_list.tr);
    }
    return ListView.separated(
      itemBuilder: (_, index) => EventItem(event: controller.events[index]),
      separatorBuilder: (_, __) => SizedBox(
        height: 12,
      ),
      padding: EdgeInsets.all(32),
      itemCount: controller.events.length,
    );
  }
}
