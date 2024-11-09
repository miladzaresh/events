import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils.dart';
import '../../shared/widget/general_button.dart';
import '../../shared/widget/loading_app.dart';
import '../../shared/widget/retry_widget.dart';
import '../controller/event_details_controller.dart';
class EventDetailsScree extends GetView<EventDetailsController> {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.event_details_page_name.tr,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Obx(()=>_body()),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: GeneralButton(
            title: LocaleKeys.event_details_page_purchases.tr,
            onPress: controller.onPurchase,
          ),
        ),
      );
  Widget buildImage(){
    return Container(
      height: 150,
      child: controller.event.value!.image != null?null:Icon(Icons.image,color: Colors.grey.shade500,size: 25,),
      decoration: BoxDecoration(
        image: controller.event.value!.image==null?null:DecorationImage(
            image: MemoryImage(
              decodeBase64ToFile(controller.event.value!.image!),
            ),
            fit: BoxFit.cover
        ),
        color: Colors.grey.shade300,
      ),
      alignment: Alignment.center,
    );
  }

  Widget _body(){
    if(controller.isLoading.value){
      return LoadingApp();
    }else if(controller.event.value == null){
      return RetryWidget(onTap: controller.getEvent);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          SizedBox(height: 16,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.event.value!.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 12,),
                Text(
                  controller.event.value!.description,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Icon(Icons.date_range,size: 24,color: Colors.grey,),
                        SizedBox(width: 4,),
                        Text(
                          controller.event.value!.dateTime,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade800
                          ),
                        )
                      ],
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Icon(Icons.price_check,size: 24,color: Colors.grey,),
                        SizedBox(width: 4,),
                        Text(
                          controller.event.value!.price.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade800
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );;
  }
}
