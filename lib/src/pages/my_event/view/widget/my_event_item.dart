import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/utils.dart';
import '../../../shared/widget/loading_app.dart';
import '../../controller/my_event_controller.dart';
import '../../model/my_event_view_model.dart';

class MyEventItem extends GetView<MyEventController> {
  final MyEventViewModel event;

  MyEventItem({required this.event});

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: expiredDateOpacity(),
    child: DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        event.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      '\$ ${event.price}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade200),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

  Widget buildImage() {
    return Stack(
      // alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 150,
          child: event.image != null
              ? null
              : Icon(
                  Icons.image,
                  color: Colors.grey.shade500,
                  size: 25,
                ),
          decoration: BoxDecoration(
            image: event.image == null
                ? null
                : DecorationImage(
                    image: MemoryImage(
                      decodeBase64ToFile(event.image!),
                    ),
                    fit: BoxFit.cover),
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          alignment: Alignment.center,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 23)
                ]),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(16),
            child: Text(
              '${event.dateTime.day.toString()} \n ${checkMonth(event.dateTime)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Obx(() => controller.deleteLoading[event.id.toString()]
                  ? Transform.scale(
                      child: LoadingApp(),
                      scale: 0.5,
                    )
                  : optionItem(() {
                      controller.deleteEvent(event);
                    }, Icons.delete)),
              SizedBox(
                width: 8,
              ),
              optionItem((){
                controller.goToEditPage(event);
              }, Icons.edit),
            ],
          ),
        )
      ],
    );
  }

  double expiredDateOpacity()=>event.dateTime.isBefore(DateTime.now())?0.5:1.0;

  Widget optionItem(Function() onTap, IconData icon) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade400, blurRadius: 23)
            ]),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 24,
          color: Colors.grey,
        ),
      ),
      onTap: onTap,
    );
  }
}
