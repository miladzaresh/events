import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/utils.dart';
import '../../../shared/widget/loading_app.dart';
import '../../controller/event_list_controller.dart';
import '../../model/event_view_model.dart';
class EventItem extends GetView<EventListController> {
  final EventViewModel event;

  EventItem({required this.event});

  @override
  Widget build(BuildContext context)=>
      GestureDetector(
        child: Opacity(
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:BorderRadius.circular(25)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImage(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              event.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                          child: Text(
                            '\$ ${event.price}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade200
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          opacity: expiredDateOpacity(),
        ),
        onTap: (){
          controller.goToDetails(event.id,expiredDateOpacity() == 1.0);
        },
      );
  Widget buildImage(){
    return Stack(
      children: [
        Container(
          height: 150,
          child: event.image != null?null:Icon(Icons.image,color: Colors.grey.shade500,size: 25,),
          decoration: BoxDecoration(
              image: event.image==null?null:DecorationImage(
                  image: MemoryImage(
                      decodeBase64ToFile(event.image!),
                  ),
                fit: BoxFit.cover
              ),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
          ),
          alignment: Alignment.center,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(()=>bookmarkBtn()),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 12
                      ),
                    ],
                    shape: BoxShape.circle
                ),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                child: Text(
                  '${event.dateTime.day.toString()} \n ${checkMonth(event.dateTime)}' ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget bookmarkBtn(){
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 12
              ),
            ],
            shape: BoxShape.circle
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        child: controller.bookmarkLoading[event.id.toString()]?Transform.scale(scale: 0.5,child: LoadingApp(),):Icon(event.isBookmark?Icons.bookmark_add_rounded:Icons.bookmark_add_outlined,size: 24,color: event.isBookmark?Colors.red.shade600:Colors.grey.shade600,),
      ),
      onTap: (){
        controller.bookmarkEvent(event);
      },
    );
  }
  double expiredDateOpacity()=>event.dateTime.isBefore(DateTime.now())?0.5:1.0;

}
